// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import {HackerPelusa} from "../src/HackerPelusa.sol";
import {Pelusa} from "../src/Pelusa.sol";

contract TestPelusa is Test{
    HackerPelusa expl;
    Pelusa pel;

    address hacker = makeAddr("hacker");
    address pelusaDeployer= makeAddr("pelusaDeployer");

    // function testFailFindCreate2Salt() public {
    //     vm.prank(pelusaDeployer);
    //     pel = new Pelusa();
    //     vm.prank(hacker);
    //     for(uint i=0;i<1000;i++){
    //         vm.expectRevert();
    //         emit log_uint(i);
    //         expl = new HackerPelusa{salt:bytes32(uint256(i))}(pel,pelusaDeployer,blockhash(block.number));
    //     }
    // } // We got salt value 42 for 

    function testGoals() public {
        vm.prank(pelusaDeployer);
        pel = new Pelusa();
         vm.startPrank(hacker);
        expl = new HackerPelusa{salt: bytes32(uint256(49))}(pel,pelusaDeployer,blockhash(block.number));
        pel.shoot();
        vm.stopPrank();
        assertTrue(pel.goals()==2);
    }

    
}