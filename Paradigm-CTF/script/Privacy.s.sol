// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from "forge-std/Script.sol";
import {Privacy} from "../src/Privacy.sol";

contract DeployPrivacy is Script {
    bytes32[3] private _data=[bytes32("hello"),bytes32("belo"),bytes32("cello")];
    function run() public {
        vm.startBroadcast();
        new Privacy(_data);
        vm.stopBroadcast();
    }
}
