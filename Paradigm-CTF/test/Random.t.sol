// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {Test} from "forge-std/Test.sol";
import {Random} from "../src/Random.sol";
import {Setup} from "../src/RandomSetup.sol";

contract TestRadnom is Test{
    Random random;
    Setup setup;
    function setUp() public {
        random = new Random();
        setup = new Setup(address(random));
    }

    function testRandom() public {
        assertTrue(!setup.isSolved());
        random.solve(4);
        assertTrue(setup.isSolved());
    }
}