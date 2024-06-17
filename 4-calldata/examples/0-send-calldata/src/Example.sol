// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract A {
    uint256 public sum;
    address b;

    constructor(address _b) {
        b = _b;

        // sum = iB(b).add(15, 10, 25);
        (bool success, bytes memory returnData) = b.call(
            /* In signature do not put spaces, test will fail */
            abi.encodeWithSignature("add(uint256,uint256)", 1, 5)
        );
        sum = abi.decode(returnData, (uint256));
        require(success);
    }
}

interface iB {
    // function add(uint256, uint256, uint256) external pure returns (uint256);
    function add(uint256, uint256) external pure returns (uint256);
}

contract B {
    // When no signature is match
    fallback() external {
        console.logBytes(msg.data);
    }

    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }
}
