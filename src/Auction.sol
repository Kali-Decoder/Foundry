// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Auction {
    uint256 public startDate = block.timestamp + 1 days;
    uint256 public endDate = block.timestamp + 3 days;
    uint256 public bidAmount;
    address public bidAddress;

    function bid() public {
        require(block.timestamp >= startDate && endDate > block.timestamp, "Bid Is Not Over");
        // if(bidAmount<msg.value){
        //     bidAmount= msg.value;
        //     bidAddress= msg.sender;
        // }
    }

    function end() public {
        require(block.timestamp >= endDate, "Cannot End");
    }
}
