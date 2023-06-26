// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Confidential {
    string public firstUser = "ALICE";
    uint256 public alice_age = 24;
    bytes32 private ALICE_PRIVATE_KEY; //Super Secret Key
    bytes32 public ALICE_DATA = "QWxpY2UK";
    bytes32 private aliceHash = hash(ALICE_PRIVATE_KEY, ALICE_DATA);

    string public secondUser = "BOB";
    uint256 public bob_age = 21;
    bytes32 private BOB_PRIVATE_KEY; // Super Secret Key
    bytes32 public BOB_DATA = "Qm9iCg";
    bytes32 private bobHash = hash(BOB_PRIVATE_KEY, BOB_DATA);

    constructor() {}

    function hash(bytes32 key1, bytes32 key2) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(key1, key2));
    }

    function checkthehash(bytes32 _hash) public view returns (bool) {
        require(_hash == hash(aliceHash, bobHash));
        return true;
    }
}
// cast call $CONTRACT_ADDRESS "hash(bytes32,bytes32)" "0x9371c02eefbd06113fb7e1ce6d27c3c7f6c8fc4d1b5f5f6b2620cd04d1610e3f" "0x23884ae3f28ba61fa99f4875e67f11b7c95e1f490cdf5f362c088e4ffaba0855" 
// Get the hash of the two  keys :- 0x6604b29fc22947564ad57b21d6e6d6f8374979380b3695bcab1d95a5ef190f08
// cast call $CONTRACT_ADDRESS "checkthehash(bytes32 _hash)" "0x6604b29fc22947564ad57b21d6e6d6f8374979380b3695bcab1d95a5ef190f08" --rpc-url $RPC_URL --private-key $PRIVATE_KEY 
//0x0000000000000000000000000000000000000000000000000000000000000001 Get--> one means true