// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

/*
 * @title Escrow
 * @author iamsidar07
 * @notice Escrow example
 */
contract Escrow {
    event Approved(uint256);

    address public depositor; // contract deployer who deposit money initially
    address public beneficiary; // get fund in exchange of good/service
    address public arbiter; // approver for fund to the beneficiary;

    // @notice You are not the arbiter
    error NotArbiter();
    // @notice approval failed
    error TransactionFailed();

    // Make it payable so depositor can put some money when deploying
    /*
     *@dev Store variable
     *@param _arbiter address of arbiter variable
     *@param _beneficiary address of beneficiary variable
     */
    constructor(address _arbiter, address _beneficiary) {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    /*
    @notice transfer all contract balance to the beneficiary address, only call by arbiter
    */
    function approve() external {
        // only approver can call this function
        if (msg.sender != arbiter) {
            revert NotArbiter();
        }
        // transfer all fund in the contract to beneficiary address
        uint256 balance = address(this).balance;
        (bool success, ) = beneficiary.call{value: balance}("");
        if (!success) {
            revert TransactionFailed();
        }
        // emit event Approved() by taking approved balance as input in event
        emit Approved(balance);
    }
}
