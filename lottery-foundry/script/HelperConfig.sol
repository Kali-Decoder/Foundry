// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";
import {LinkToken} from "../test/LinkToken.sol";
contract HelperConfig is Script {
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    struct NetworkConfig {
        address _vrfCoordinator;
        bytes32 _gasLane;
        uint64 _subscriptionId;
        uint32 _callbackGasLimit;
        address _link;
        uint _deployerKey;
    }

    NetworkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 5) {
            activeNetworkConfig = getGoerliNetworkDetail();
        } else {
            activeNetworkConfig = getOrCreateAnvilNetworkDetails();
        }
    }

    function getGoerliNetworkDetail() public  returns (NetworkConfig memory) {
        return NetworkConfig({
            _vrfCoordinator: 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D,
            _gasLane: 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15,
            _subscriptionId: 12786,
            _callbackGasLimit: 500000,
            _link:0x326C977E6efc84E512bB9C30f76E30c160eD06FB,
            _deployerKey: vm.envUint("PRIVATE_KEY")
        });
    }

    function getOrCreateAnvilNetworkDetails() public returns (NetworkConfig memory) {
        if (activeNetworkConfig._vrfCoordinator != address(0)) {
            return activeNetworkConfig;
        }
        uint96 baseFee = 0.25 ether;
        uint96 baseLinkFee = 1e9;

        vm.startBroadcast();
        VRFCoordinatorV2Mock vrfCoordinateMock = new VRFCoordinatorV2Mock(baseFee,baseLinkFee);
        vm.stopBroadcast();
        LinkToken link = new LinkToken();
        return NetworkConfig({
            _vrfCoordinator: address(vrfCoordinateMock),
            _gasLane: 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15,
            _subscriptionId: 0,
            _callbackGasLimit: 500000,
            _link: address(link),
            _deployerKey: DEFAULT_ANVIL_PRIVATE_KEY
        });
    }
}
