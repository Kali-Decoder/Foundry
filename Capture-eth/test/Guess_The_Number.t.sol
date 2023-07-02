// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";

import {GuessTheNumberChallenge} from "../src/Guess_The_Number.sol";

contract TestGuessNumber is Test{
    GuessTheNumberChallenge guessTheNumberChallenge;

    function runUp() public {
        guessTheNumberChallenge = new GuessTheNumberChallenge();
    }

    function testGuess() public {
        vm.prank(address(1));
        vm.deal(address(1),1 ether);
        guessTheNumberChallenge.guess{value:1 ether}(42);
      
      
    }
    // function testGetBalance() public {
    //     uint bal = guessTheNumberChallenge.getBal();
    //     assertEq(bal, 1 ether);
    // }
}