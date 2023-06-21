// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Owner.sol";

contract OwnerTest is Test {
    Owner public _owner;

    function setUp() public {
        _owner = new Owner();
    }

    function testOwner() public {
        _owner.setOwner(address(1));
        address _ow = _owner.getOwner();
        assertEq(_ow, address(1));
    }

    function testFailNotOwner() public {
        vm.prank(address(3)); // We change the caller address to 3 that is not the owner owner is your wallet only
        _owner.setOwner(address(1));
    }

    function testFailNotOwnerAgain() public {
        _owner.setOwner(address(1));
        vm.startPrank(address(1));
        _owner.setOwner(address(1));
        _owner.setOwner(address(1));
        _owner.setOwner(address(1));
        _owner.setOwner(address(1));
        _owner.setOwner(address(1));
        _owner.setOwner(address(1));
        vm.stopPrank();
        _owner.setOwner(address(1)); // Test fail
    }
}
