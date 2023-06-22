// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ManualToken} from "../src/ManualToken.sol";
import {Script} from "forge-std/Script.sol";

contract DeployManualToken is Script {
    function run() public {
        vm.startBroadcast();
        new ManualToken();
        vm.stopBroadcast();
    }
}