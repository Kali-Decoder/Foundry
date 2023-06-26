// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;
contract VIP_Bank{

    address public manager;
    mapping(address => uint) public balances;
    mapping(address => bool) public VIP;
    uint public maxETH = 0.5 ether;

    constructor() {
        manager = msg.sender;
    }

    modifier onlyManager() {
        require(msg.sender == manager , "you are not manager");
        _;
    }

    modifier onlyVIP() {
        require(VIP[msg.sender] == true, "you are not our VIP customer");
        _;
    }

    function addVIP(address addr) public onlyManager {
        VIP[addr] = true;
    }

    function deposit() public payable onlyVIP {
        require(msg.value <= 0.05 ether, "Cannot deposit more than 0.05 ETH per transaction");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public onlyVIP {
        require(address(this).balance <= maxETH, "Cannot withdraw more than 0.5 ETH per transaction");
        require(balances[msg.sender] >= _amount, "Not enough ether");
        balances[msg.sender] -= _amount;
        (bool success,) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdraw Failed!");
    }

    function contractBalance() public view returns (uint){
        return address(this).balance;
    }


}

// cast call $CONTRACT_ADDRESS_VIPCONTRACT "manager()" --rpc-url $RPC_URL --private-key $PRIVATE_KEY
// cast send $CONTRACT_ADDRESS_VIPCONTRACT "addVIP(address)" "0x70997970C51812dc3A010C7d01b50e0d17dc79C8" --rpc-url $RPC_URL --private-key $PRIVATE_KEY
// cast call $CONTRACT_ADDRESS_VIPCONTRACT "VIP(address)" "0x70997970C51812dc3A010C7d01b50e0d17dc79C8" --rpc-url $RPC_URL --private-key $PRIVATE_KEY
// cast send $CONTRACT_ADDRESS_VIPCONTRACT "deposit()" --value "0.05ether" "0x70997970C51812dc3A010C7d01b50e0d17dc79C8" --rpc-url $RPC_URL --private-key 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
// cast call $CONTRACT_ADDRESS_VIPCONTRACT "balances(address)" "0x70997970C51812dc3A010C7d01b50e0d17dc79C8" --rpc-url $RPC_URL --private-key 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
// cast call $CONTRACT_ADDRESS_VIPCONTRACT "contractBalance()"  --rpc-url $RPC_URL --private-key $PRIVATE_KEY
// cast send $CONTRACT_ADDRESS_VIPCONTRACT "withdraw(uint)" "400" "0x70997970C51812dc3A010C7d01b50e0d17dc79C8" --rpc-url $RPC_URL --private-key 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d