// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Example {
    uint256 public sum;
    uint256 public product;

    constructor(uint256 x, uint256 y) {
        (sum, product) = math(x, y);
    }

    function math(
        uint256 _x,
        uint256 _y
    ) public pure returns (uint256, uint256) {
        return (_x + _y, _x * _y);
    }
}
