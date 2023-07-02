// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract GuessTheNumberChallenge {
    uint8 answer = 42;

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether,"Not enough ether");

        if (n == answer) {
            payable(msg.sender).transfer(1 ether);
        }
    }
    receive() external payable {}

    function getBal() public view returns(uint){
        return address(this).balance;
    }
}