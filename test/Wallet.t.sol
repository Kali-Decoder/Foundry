// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";

contract TestWallet is Test {
    Wallet public wallet;
    uint bal = address(wallet).balance;
    function setup() public{
        wallet = new Wallet();
    }

    function _send(uint amt) private {
        (bool ok,) = address(wallet).call{value: amt}("");
        require(ok,"Ether send failed"); 
    }

    function testEthBalance() public {
        console.log("Eth Balance in contract",address(this).balance/1e18);
    }

    function testSendEth() public {
        // deal(address,amount) to set the balance for this address 
        deal(address(1),100);
        assertEq(address(1).balance,100);
        

        deal(address(1),123);
        vm.prank(address(1));
        _send(123);
        // hoax(address,amount) to set the prank wallet address
            hoax(address(1),456);
            _send(456);

            assertEq(address(wallet).balance , bal + 123 + 456);

    }
}
