// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {Script} from "forge-std/Script.sol";
import {Random} from "../src/Random.sol";
contract DeployRandom is Script{
    function run() public{
        vm.startBroadcast();
        new Random();
        vm.stopBroadcast();
    }
}