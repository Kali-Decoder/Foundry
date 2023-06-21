// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/Erc721.sol";

contract TestERC721 is Test {
    MyNFT public erc721;

    event Transfer(address indexed from, address indexed to, uint256 indexed id);
    event Approval(address indexed owner, address indexed spender, uint256 indexed id);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    address public bob = address(1);
    address public alice = address(2);
    address public cat = address(3);

    function setUp() public {
        erc721 = new MyNFT();
    }

    function testMintingERC721() public {
        erc721.mint(bob, 0);
        address _owner = erc721.ownerOf(0);
        uint256 iud = erc721.balanceOf(bob);
        assertEq(iud, 1);
        assertEq(bob, _owner);
    }

    function testOwnerOfToken() public {
        erc721.mint(bob, 0);
        address _owner = erc721.ownerOf(0);
        assertEq(bob, _owner);
    }

    function testTransferFrom() public {
        erc721.mint(bob, 0);
        vm.startPrank(bob);
        erc721.safeTransferFrom(bob, alice, 0);
        address _owner = erc721.ownerOf(0);
        assertEq(alice, _owner);
        uint256 iud = erc721.balanceOf(alice);
        assertEq(iud, 1);
    }

    function testGetBalance() public {
        erc721.mint(bob, 0);
        erc721.mint(bob, 1);
        erc721.mint(bob, 2);
        erc721.mint(bob, 3);
        erc721.mint(bob, 4);
        erc721.mint(bob, 5);
        uint256 bal = erc721.balanceOf(bob);
        assertEq(bal, 6);
    }

    function testOnlyOwnerBurn() public {
        erc721.mint(bob, 0);
        // vm.expectRevert("not owner of token");
        vm.startPrank(bob);
        erc721.burn(0);
        uint256 bal = erc721.balanceOf(bob);
        assertEq(bal, (0));
    }

    function testFailBurn() public {
        erc721.mint(bob, 0);
        vm.startPrank(alice); // Called by other address not owner
        erc721.burn(0);
    }

    function testApprove() public {
        erc721.mint(bob, 0);
        vm.prank(bob);
        erc721.approve(alice, 0);
        address _owner = erc721.ownerOf(0);
        assertEq(bob, _owner);
        address _approved = erc721.getApproved(0);
        assertEq(alice, _approved);
    }

    function testGetApprove() public {
        erc721.mint(bob, 0);
        vm.prank(bob);
        erc721.approve(alice, 0);
        address _approved = erc721.getApproved(0);
        assertEq(_approved, alice);
    }

    function testSetApprovalForAll() public {
        erc721.mint(bob, 0);
        vm.prank(bob);
        erc721.setApprovalForAll(alice, true);
        bool _approved = erc721.isApprovedForAll(bob, alice);
        assertEq(_approved, true);
    }

    // Testing of events

    function testTransferEvent() public {
        erc721.mint(bob, 0);
        vm.expectEmit(true, true, true, false);
        emit Transfer(bob, alice, 0);
        vm.prank(bob);
        erc721.safeTransferFrom(bob, alice, 0);
    }

    function testApprovalEvent() public {
        erc721.mint(bob, 0);
        vm.expectEmit(true, true, true, false);
        emit Approval(bob, alice, 0);
        vm.prank(bob);
        erc721.approve(alice, 0);
    }

    function testApprovalForAllEvent() public {
        erc721.mint(bob, 0);
        vm.expectEmit(true, true, true, false);
        emit ApprovalForAll(bob, alice, true);
        vm.prank(bob);
        erc721.setApprovalForAll(alice, true);
    }
}
