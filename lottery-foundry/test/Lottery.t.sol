// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployLottery} from "../script/Lottery.s.sol";
import {Lottery} from "../src/Lottery.sol";
import {HelperConfig} from "../script/HelperConfig.sol";

contract TestLottery is Test {
    Lottery lottery;
    HelperConfig helperConfig;
    address _vrfCoordinator;
    bytes32 _gasLane;
    uint64 _subscriptionId;
    uint32 _callbackGasLimit;
    address _link;
    address public PLAYER = makeAddr("playerone");
    uint256 public constant BALANCE = 0.25 ether;
     event EnterLottery(address indexed player, uint indexed amount);
    function setUp() public {
        DeployLottery deployer = new DeployLottery();
        (lottery, helperConfig) = deployer.run();
        (_vrfCoordinator, _gasLane, _subscriptionId, _callbackGasLimit,_link) = helperConfig.activeNetworkConfig();
    }


    function testLotteryState() public {
        uint256 state = lottery.getLotteryState();
        assertEq(state, 0, "Lottery should be in state 0");
    }

    function testFailInsufficientBalanceDeposit() public {
        vm.prank(PLAYER);
        vm.expectRevert(Lottery.InvalidTicketPrice.selector);
        lottery.enterLottery();
    }

    function testEnterLottery() public {

        //Event Test Is Also there 
        vm.expectEmit(true, true, false, false);
        vm.prank(PLAYER);
        vm.deal(PLAYER, 1 ether);
        emit EnterLottery(PLAYER,0.1 ether);
        lottery.enterLottery{value:0.1 ether}();
        address player = lottery.getPlayerByIndex(0);
        assertEq(PLAYER,player);
    }

    function testInterval() public{
        uint256 interval = lottery.getInterval();
        assertEq(interval, 2 days);
    }

    function testCantEnterWhenTheLotteryIsGoingOn() public{
        vm.prank(PLAYER);
        vm.deal(PLAYER, 1 ether);
        lottery.enterLottery{value:0.1 ether}();
        uint256 interval = lottery.getInterval();
        vm.warp(block.timestamp + 1 + interval );
        vm.roll(block.number+1);

        lottery.performUpkeep("");

        vm.expectRevert(Lottery.Lottery__LotteryNotOpen.selector);
        vm.prank(PLAYER);
        vm.deal(PLAYER, 1 ether);
        lottery.enterLottery{value:0.1 ether}();

    }
}
