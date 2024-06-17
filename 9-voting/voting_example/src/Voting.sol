// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint256 yesCount;
        uint256 noCount;
        mapping(address => bool) vote;
    }

    Proposal[] public proposals;
    mapping(uint256 => address[]) public proposalIdToVoters;
    address[] public members;

    constructor(address[] memory _members) {
        members.push(msg.sender);
        for (uint256 i = 0; i < _members.length; i++) {
            members.push(_members[i]);
        }
    }

    modifier onlyMember() {
        require(_isMember(msg.sender));
        _;
    }

    function _isMember(address _member) private view returns (bool) {
        bool isMember = false;
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == _member) {
                isMember = true;
            }
        }
        return isMember;
    }

    function newProposal(
        address _target,
        bytes memory _calldata
    ) external onlyMember {
        Proposal storage proposal = proposals.push();
        proposal.data = _calldata;
        proposal.target = _target;
        proposal.yesCount = 0;
        proposal.noCount = 0;
    }

    function _hasVoted(
        address _voter,
        uint256 proposalId
    ) private view returns (bool) {
        bool hasVoted = false;
        for (uint i = 0; i < proposalIdToVoters[proposalId].length; i++) {
            if (proposalIdToVoters[proposalId][i] == _voter) {
                hasVoted = true;
            }
        }
        return hasVoted;
    }

    function castVote(uint256 proposalId, bool toSupport) external onlyMember {
        Proposal storage proposal = proposals[proposalId];

        // Check who has voted allready
        if (_hasVoted(msg.sender, proposalId)) {
            if (proposal.vote[msg.sender]) {
                proposal.yesCount--;
                proposal.noCount++;
                proposal.vote[msg.sender] = false;
            } else {
                proposal.yesCount++;
                proposal.noCount--;
                proposal.vote[msg.sender] = true;
            }
        } else {
            if (toSupport) {
                proposal.yesCount++;
            } else {
                proposal.noCount++;
            }
            proposal.vote[msg.sender] = toSupport;
            proposalIdToVoters[proposalId].push(msg.sender);
        }

        if (proposal.yesCount == 10) {
            proposal.target.call(proposal.data);
        }
    }
}
