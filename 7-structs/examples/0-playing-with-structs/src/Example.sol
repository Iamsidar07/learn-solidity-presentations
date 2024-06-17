// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }
    mapping(uint256 => address) public proposalIdToOwner;
    mapping(uint256 => mapping(address => bool))
        public proposalIdToOwnerToSupport;

    Proposal[] public proposals;

    function newProposal(address _target, bytes memory _calldata) external {
        Proposal memory proposal = Proposal(_target, _calldata, 0, 0);
        proposals.push(proposal);
    }

    function castVote(uint256 proposalId, bool supportProposal) external {}
}
