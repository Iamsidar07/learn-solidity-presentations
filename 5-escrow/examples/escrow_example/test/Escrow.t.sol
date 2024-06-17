// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;
import {Test, console} from "forge-std/Test.sol";
import "../src/Escrow.sol";

contract EscrowTest is Test {
    A public aribter;
    B public beneficiary;
    Escrow public escrow;

    function setup() public {
        arbiter = new A();
        beneficiary = new B();
        escrow = new Escrow{value: 2 ether}(
            address(aribter),
            address(beneficiary)
        );
    }

    function testExample() public view {
        assertEq(address(escrow).balance, 2 ether);
        assertEq(escrow.depositor, msg.sender);
    }
}

contract A {
    
}

contract B {
    // can accept balance
    receive() external payable {}
}
