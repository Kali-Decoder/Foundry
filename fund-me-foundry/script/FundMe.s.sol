// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/FundMe.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new FundMe(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        vm.stopBroadcast();
    }
}
