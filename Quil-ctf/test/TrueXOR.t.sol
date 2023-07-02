// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "forge-std/Test.sol";
import {HackerXOR} from "../src/HackerXOR.sol";
import {TrueXOR} from  "../src/XOR.sol";

contract TrueXORTest is Test {
    TrueXOR trueXor;
    HackerXOR exploit;

    function setUp() external {
        trueXor = new TrueXOR();
        exploit = new HackerXOR();
    }

    function testExploit() external {
        vm.prank(msg.sender);
        bool success = trueXor.callMe{gas: 10000}(address(exploit));
        assertTrue(success);
    }
}