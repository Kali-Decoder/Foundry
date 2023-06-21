// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Event {
    event Transfer(address indexed from, address indexed to, uint256 value);

    function depositMoney(address to, address from, uint256 value) public {
        emit Transfer(from, to, value);
    }

    function multipleDeposit(address[] memory to, address from, uint256[] memory value) public {
        for (uint256 i = 0; i < to.length; i++) {
            emit Transfer(from, to[i], value[i]);
        }
    }
}
