// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import {Script} from "forge-std/Script.sol";

import {Confidential} from "../src/ConfidentialHash.sol";

contract DeployRoadClosed is Script {
    function run() public {
        vm.startBroadcast();
        new Confidential();
        vm.stopBroadcast();
    }
}
