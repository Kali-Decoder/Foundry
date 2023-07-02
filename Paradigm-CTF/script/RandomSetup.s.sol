// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {Script} from "forge-std/Script.sol";
import {Setup} from "../src/RandomSetup.sol";
contract DeploySetup is Script{
    function run() public{
        vm.startBroadcast();
        new Setup(0x5FbDB2315678afecb367f032d93F642f64180aa3);
        vm.stopBroadcast();
    }
}