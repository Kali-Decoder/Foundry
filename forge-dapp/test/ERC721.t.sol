// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import 'src/ERC721.sol';

contract ERC721Test is Test {
    DevconPanda devconPanda;
    address noah = address(0x1);
    address sofia = address(0x2);

    function setUp() public {
      devconPanda = new DevconPanda();
    }

    function testMint() public {
      devconPanda.mint(noah, "testhash");
      address owner_of = devconPanda.ownerOf(0);
      assertEq(noah, owner_of);
    }
}