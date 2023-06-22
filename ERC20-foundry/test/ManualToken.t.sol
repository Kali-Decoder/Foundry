// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Test} from "forge-std/Test.sol";
import {ManualToken} from "../src/ManualToken.sol";
contract TestManualToken is Test{
    ManualToken manualToken;
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    event Burn(address indexed from, uint256 amount);
    function setUp() public {
       manualToken  = new ManualToken();
    }

    function testTransferTokens() public {
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), address(1), 3000000);
        manualToken.transfer(address(1), 3000000);
        uint256 balance = manualToken.balanceOf(address(1));
        assertEq(balance, 3000000);
    }

    function testApprove() public {
        vm.expectEmit(true, true, false, true);
        emit Approval(address(this), address(1), 3000000);
        manualToken.approve(address(1), 3000000);
        uint256 allowance = manualToken.getAllowance(address(this), address(1));
        assertEq(allowance, 3000000);
    }

    function testBurn() public {
        vm.expectEmit(true, true, false, true);
        emit Burn(address(this), 3000000);
        uint256 previous_balance = manualToken.totalSupply();
        manualToken.burn(3000000);
        uint256 current_balance = manualToken.totalSupply();
        assertTrue(previous_balance>current_balance);
    }
    // Testing Getting Functions

    function testName() public {
        string memory name = manualToken.name();
        assertEq(name, "Manual Token");
    }

    function testSymbol() public {
        string memory symbol = manualToken.symbol();
        assertEq(symbol, "MTC");
    }

    function testDecimals() public {
        uint8 decimals = manualToken.decimals();
        assertEq(decimals, 18);
    }

    function testTotalSupply() public {
        uint256 totalSupply = manualToken.totalSupply();
        assertEq(totalSupply, 10e18);
    }

    function testBalanceOf() public {
        uint256 balance = manualToken.balanceOf(address(this));
        assertEq(balance, 10e18);
    }
}   