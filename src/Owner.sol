// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Owner {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function setOwner(address _addr) public {
        require(owner == msg.sender, "You are not the owner");
        owner = _addr;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
