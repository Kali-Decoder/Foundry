// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from "forge-std/Script.sol";
import {Elevator} from "../src/Elevator.sol";
contract DeployElevator is Script{
    function run() public{
        vm.startBroadcast();
        new Elevator();
        vm.stopBroadcast();
    }
}