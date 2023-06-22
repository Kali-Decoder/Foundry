// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Lottery} from "../src/Lottery.sol";
import {HelperConfig} from "./HelperConfig.sol";
import {CreateSubscription} from "./Interaction.s.sol";
contract DeployLottery is Script {
    function run() public returns (Lottery, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        address _vrfCoordinator ; 
        bytes32 _gasLane ; 
        uint64 _subscriptionId ; 
        uint32 _callbackGasLimit;
        address _link;
        (_vrfCoordinator,_gasLane,_subscriptionId,_callbackGasLimit,_link) =
            helperConfig.activeNetworkConfig();

        if(_subscriptionId==0){
            CreateSubscription _createSubscription = new CreateSubscription();
            _subscriptionId = _createSubscription.createSubscriptionIdUsingHelper();
        }    
        vm.startBroadcast();
        Lottery lottery = new Lottery(_vrfCoordinator,_gasLane,_subscriptionId,_callbackGasLimit);
        vm.stopBroadcast();
        return (lottery, helperConfig);
    }
}
