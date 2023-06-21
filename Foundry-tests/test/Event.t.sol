// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Event.sol";

contract TestEvent is Test {
    Event public _event;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        _event = new Event();
    }

    function testEmitTransferEvent() public {
        // 1. TELL FOUNDARY WHICH DATA TO CHECK
        vm.expectEmit(true, true, false, true);
        // 2. EMIT THE EXPECT EVENT
        emit Transfer(address(this), address(1), 20);
        // 3. CALL THE FUCNTION THAT SHOULD EMIT THE EVENT
        _event.depositMoney(address(1), address(this), 20);
    }

    function testEmitMultipleTransferEvent() public {
        address[] memory addresses = new address[](3);
        addresses[0] = address(1);
        addresses[1] = address(2);
        addresses[2] = address(3);
        uint256[] memory amounts = new uint[](3);
        amounts[0] = (10);
        amounts[1] = (20);
        amounts[2] == (30);
        for (uint256 i = 0; i < amounts.length; i++) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), addresses[i], amounts[i]);
        }
        _event.multipleDeposit(addresses, address(this), amounts);
    }
}
