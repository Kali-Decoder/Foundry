// SPDX-License-Identifier: MIT
// totalSupply()

// balanceOf(account)

// transfer(recipient, amount)

// allowance(owner, spender)

// approve(spender, amount)

// transferFrom(sender, recipient, amount)

pragma solidity ^0.8.0;

contract ManualToken {
    uint256 public totalSupply;
    uint8 public decimals;
    string public name;
    string public symbol;
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    event Burn(address indexed from, uint256 amount);

    constructor() {
        totalSupply = 10e18;
        decimals = 18;
        name = "Manual Token";
        symbol = "MTC";
        balances[msg.sender] = totalSupply;
    }
    // State Fucntions

    function _transfer(address _from, address recipient, uint256 amount) internal {
        require(recipient != address(0));
        require(balances[_from] >= amount, "Insufficient Balance");
        require(balances[recipient] + amount >= balances[recipient]);
        uint256 previousBalances = balances[_from] + balances[recipient];
        balances[_from] -= amount;
        balances[recipient] += amount;
        emit Transfer(_from, recipient, amount);
        assert(balances[_from] + balances[recipient] == previousBalances);
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient Balance");
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function burn(uint256 amount) public returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient Balance");
        balances[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(msg.sender, amount);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowances[_from][msg.sender]); // Check allowance
        allowances[_from][msg.sender] -= _value;
        transfer(_to, _value);
        return true;
    }

    //Getter Functions

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function getAllowance(address owner, address spender) public view returns (uint256) {
        return allowances[owner][spender];
    }
}
