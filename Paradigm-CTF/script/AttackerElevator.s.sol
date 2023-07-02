// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from "forge-std/Script.sol";

import {AttackerElevator} from "../src/AttackerElevator.sol";

contract DeployAttacker is Script {
    function run() public {
        vm.startBroadcast();
        new AttackerElevator(0x5FbDB2315678afecb367f032d93F642f64180aa3);
        vm.stopBroadcast();
    }
}