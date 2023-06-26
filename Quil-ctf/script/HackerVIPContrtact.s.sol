// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import {Script} from "forge-std/Script.sol";

import {HackerVIPContract} from "../src/HackerVIPContract.sol";

contract DeployedHackerVIPContract is Script {
    function run() public {
        vm.startBroadcast();
        new HackerVIPContract{value:0.6 ether}(0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512);
        vm.stopBroadcast();
    }
}
