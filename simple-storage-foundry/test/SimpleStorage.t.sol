// SPDX-License-Identifier: MIT
pragma solidity  0.8.19;

import "forge-std/Test.sol";
import "../src/SimpleStorage.sol";
contract TestSimpleStorage is Test {
    SimpleStorage public simpleStorage;
    function setUp() public {
        simpleStorage = new SimpleStorage();  
    }

    function testStore() public {
        simpleStorage.store(10);
        assertEq(simpleStorage.retrieve(), 10);
    }
    function testFailStore() public {
        simpleStorage.store(10);
        assertEq(simpleStorage.retrieve(), 11);
    }

    function testAddPerson() public {
        simpleStorage.addPerson("Bob", 10);
        assertEq(simpleStorage.nameToFavoriteNumber("Bob"), 10);
    }
    function testFailAddPerson() public {
        simpleStorage.addPerson("Bob", 10);
        assertEq(simpleStorage.nameToFavoriteNumber("bob"), 11);
    }
}