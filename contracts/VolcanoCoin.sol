// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {

    uint totalSupply = 10000;
    address owner;
    mapping(address => uint) public balance;
    mapping(address => Payment[]) public userPayments;

    struct Payment {
        uint amount;
        address recipient;
    }

    constructor() {
        owner = msg.sender;
        balance[owner] = totalSupply;
    }

    event NewSupply(uint);
    event Transfer(address indexed, uint);

    modifier onlyOwner() {
        require(msg.sender == owner, "You must be the owner.");
        _;
    }

    function getTotalSupply() public view returns ( uint) {
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        emit NewSupply(totalSupply);
    }

    function transfer(address _recipient, uint _amount) public {
        require(balance[msg.sender] >= _amount, "You do not have sufficient funds.");
        require(_amount > 0, "amount must be greater than 0");
        balance[msg.sender] -= _amount;
        balance[_recipient] += _amount;
        Payment memory newPayment;
        newPayment.amount = _amount;
        newPayment.recipient = _recipient;
        userPayments[msg.sender].push(newPayment);

        emit Transfer(_recipient, _amount);
    }



}