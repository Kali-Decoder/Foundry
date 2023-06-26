// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import {Script} from "forge-std/Script.sol";

import {VIP_Bank} from "../src/VIPContract.sol";

contract DeployedVIPContract is Script {
    function run() public {
        vm.startBroadcast();
        new VIP_Bank();
        vm.stopBroadcast();
    }
}
