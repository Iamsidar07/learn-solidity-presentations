// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Example.sol";

contract ExampleTest is Test {
    A public a;
    B public b;

    function setUp() public {
        b = new B();
        a = new A{value: 2 ether}(address(b));
    }

    function testExample() public {
        assertEq(address(a).balance, 2 ether);
        assertEq(address(b).balance, 0 ether);
        a.payHalf();
        assertEq(address(a).balance, 1 ether);
        assertEq(address(b).balance, 1 ether);
        a.payHalf();
        assertEq(address(a).balance, 0.5 ether);
        assertEq(address(b).balance, 1.5 ether);
    }
}
