// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TrueXOR,IBoolGiver} from "./XOR.sol";

contract HackerXOR is IBoolGiver{
    
    function giveBool() external view override returns (bool){
        return gasleft()>=6500; // For toggle the condition 
    }
    
}