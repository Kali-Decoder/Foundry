// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Wallet{

    address payable public owner;
    event Deposit(address account, uint amount);
    constructor() payable{
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Deposit(msg.sender,msg.value);
    }


    function withdraw(uint amt) public  {
        require(owner==msg.sender,"You are not owner");
        payable(msg.sender).transfer(amt);
    }

    function setOwner(address _owner) public {
      require(owner==msg.sender,"You are not owner"); 
      owner= payable(_owner); 
    }

}