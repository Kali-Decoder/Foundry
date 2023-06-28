// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {D31eg4t3} from "../src/D31eg4t3.sol";

contract DeployedDelegate is Script {
    function run() public {
        vm.startBroadcast();
        new D31eg4t3();
        vm.stopBroadcast();
    }
}
