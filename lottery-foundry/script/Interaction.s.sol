// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Script, console} from "forge-std/Script.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";
import {Lottery} from "../src/Lottery.sol";
import {HelperConfig} from "./HelperConfig.sol";
import {LinkToken} from "../test/LinkToken.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
contract CreateSubscription is Script {
    function createSubscriptionIdUsingHelper() public returns (uint64) {
        HelperConfig helperConfig = new HelperConfig();
        (address _vrfCoordinator, , , , , uint256 _deployerKey) = helperConfig
            .activeNetworkConfig();
        return _createSubscriptionId(_vrfCoordinator, _deployerKey);
    }

    function _createSubscriptionId(
        address _vrfCoordinator,
        uint _deployerKey
    ) private returns (uint64) {
        vm.startBroadcast(_deployerKey);
        uint64 subID = VRFCoordinatorV2Mock(_vrfCoordinator)
            .createSubscription();
        vm.stopBroadcast(_deployerKey);

        console.log("Subscription ID:", subID);
        return subID;
    }
}

contract FundSubscription is Script {
    uint96 public constant FUND_AMOUNT = 3 ether;

    function fundSubscriptionUsingConfig() public {
        HelperConfig helperConfig = new HelperConfig();
        (
            address _vrfCoordinator,
            ,
            uint64 _subscriptionId,
            ,
            address _link,
            uint256 _deployerKey
        ) = helperConfig.activeNetworkConfig();
        fundSubscription(_vrfCoordinator, _subscriptionId, _link);
    }

    function fundSubscription(
        address vrfCoordinatorV2,
        uint64 subId,
        address link
    ) public {
        if (block.chainid == 5) {
            vm.startBroadcast(__deployerKey);
            VRFCoordinatorV2Mock(vrfCoordinatorV2).fundSubscription(
                subId,
                FUND_AMOUNT
            );
            vm.stopBroadcast();
        } else {
            vm.startBroadcast(__deployerKey);
            LinkToken(link).transferAndCall(
                vrfCoordinatorV2,
                FUND_AMOUNT,
                abi.encode(subId)
            );
            vm.stopBroadcast();
        }
    }

    function run() public {
        fundSubscriptionUsingConfig();
    }
}

contract AddConsumer is Script {
    function addConsumer(
        address contractToAddToVrf,
        address vrfCoordinator,
        uint64 subId,
        uint256 deployerKey
    ) public {
        console.log("Adding consumer contract: ", contractToAddToVrf);
        console.log("Using vrfCoordinator: ", vrfCoordinator);
        console.log("On ChainID: ", block.chainid);
        vm.startBroadcast(deployerKey);
        VRFCoordinatorV2Mock(vrfCoordinator).addConsumer(
            subId,
            contractToAddToVrf
        );
        vm.stopBroadcast();
    }

    function addConsumerUsingConfig(address mostRecentlyDeployed) public {
        HelperConfig helperConfig = new HelperConfig();
        (
            address _vrfCoordinator,
            ,
            uint64 _subscriptionId,
            ,
            address _link,
            uint _deployerKey
        ) = helperConfig.activeNetworkConfig();
        addConsumer(mostRecentlyDeployed, _vrfCoordinator, _subscriptionId, _deployerKey);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "Lottery",
            block.chainid
        );
        addConsumerUsingConfig(mostRecentlyDeployed);
    }
}
