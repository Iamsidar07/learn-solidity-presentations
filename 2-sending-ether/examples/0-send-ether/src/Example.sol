// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract A {
    address b;

    constructor(address _b) payable {
        b = _b;
        console.log(address(this).balance);
    }

    function payHalf() external payable {
        uint256 balance = address(this).balance;
        (bool success, ) = b.call{value: balance / 2}("");
        require(success);
        console.log("b balance:", b.balance);
        console.log("a balance:", address(this).balance);
    }
}

contract B {
    receive() external payable {}
}
