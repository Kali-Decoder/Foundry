// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import {Test} from "forge-std/Test.sol";

import {VIP_Bank} from "../src/VIPContract.sol";

contract TestVIP is Test {
    VIP_Bank vip;
    function setUp() public {
        vip = new VIP_Bank();
    }

    function testManager() public {
        assertTrue(vip.manager() == address(this));
    }
    function testAddVIP() public {
        vm.prank(address(this));
        vip.addVIP(address(1));
        assertTrue(vip.VIP(address(1)));
    }

    function testDeposit() public {
        vm.prank(address(this));
        vip.addVIP(address(1));
        vm.prank(address(1));
        vm.deal(address(1),1 ether);
        vip.deposit{value:0.05 ether}();
        assertTrue(vip.balances(address(1)) == 0.05 ether);
    }

    function testWithdraw() public {
        vm.prank(address(this));
        vip.addVIP(address(1));
        vm.prank(address(1));
        vm.deal(address(1),1 ether);
        vip.deposit{value:0.05 ether}();
        vm.prank(address(1));
        vip.withdraw(0.05 ether);
        assertTrue(vip.balances(address(1)) == 0);
    }

    function testFailWithdraw() public {
         vm.prank(address(this));
        vip.addVIP(address(1));
        vm.prank(address(1));
        vm.deal(address(1),1 ether);
        vip.deposit{value:0.05 ether}();
        vm.prank(address(1));
        vip.withdraw(0.6 ether);
        assertTrue(vip.balances(address(1)) == 0);
    }

}