// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import {Script} from "forge-std/Script.sol";

import {RoadClosed} from "../src/RoadClosed.sol";

contract DeployRoadClosed is Script {
    function run() public {
        vm.startBroadcast();
        new RoadClosed();
        vm.stopBroadcast();
    }
}
