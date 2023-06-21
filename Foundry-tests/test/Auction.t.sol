// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Auction.sol";

contract AuctionTest is Test {
    Auction public auction;
    uint256 private startAt;

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    // function testFailBidBeforeStart() public {
    //     vm.expectRevert(bytes("Bid Is Not Over"));
    //     auction.bid();
    // }

    function testBid() public {
        vm.warp(startAt + 1 days); // Ek din baad start karega
        auction.bid();
    }

    function testBidFailsBeforeEndDate() public {
        vm.expectRevert(bytes("Bid Is Not Over"));
        vm.warp(startAt + 3 days);
        auction.bid();
    }

    function testTimestamp() public {
        uint256 t = block.timestamp;
        skip(100);
        assertEq(block.timestamp, t + 100, "This is true");
        rewind(10);
        assertEq(block.timestamp, t + 90, "Timestamp Rewind by 10s");
    }

    function testBlockNumber() public {
        vm.roll(999);
        assertEq(block.number, 999);
    }
}
