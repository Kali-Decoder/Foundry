// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {HackerDelegate} from "../src/HackerDelegate.sol";

contract DeployedDelegate is Script {
    function run() public {
        vm.startBroadcast();
        new HackerDelegate();
        vm.stopBroadcast();
    }
}

// forge script script/DelegateHacked.s.sol  --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast 