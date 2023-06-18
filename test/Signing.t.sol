// SPDX-License-Identifier: MIT
import "forge-std/Test.sol";

contract TestSignTransaction is Test {
    // 1. Generate private key 
    // 2. Generate public key
    // 3. Generate msg hash 
    // 4. generate signature v r s constraints 

   function testSign() public {
    uint256 privateKey = 123;
    address publicKey = vm.addr(privateKey);
    bytes32 msgHash = keccak256("Secret Message");
    
    (uint8 v , bytes32 r , bytes32 s) = vm.sign(privateKey,msgHash);
    address signer = ecrecover(msgHash, v ,r , s);
    assertEq(signer,publicKey);
   }

}   