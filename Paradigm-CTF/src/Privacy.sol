// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Privacy {

  bool public locked = true;//1 bytes
  uint256 public ID = block.timestamp; // 32bytes
  uint8 private flattening = 10;//8bytes
  uint8 private denomination = 255;//8 bytes
  uint16 private awkwardness = uint16(block.timestamp);//16bytes
  bytes32[3] private data;// 

  constructor(bytes32[3] memory _data) {
    data = _data;
  }
  function  getBytes16(bytes32 _key) public pure returns(bytes16) {
    return bytes16(_key);
  }
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }
}