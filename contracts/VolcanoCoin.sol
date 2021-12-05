// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is ERC20("Volcano Coin", "VLC" ), Ownable {

    uint initialSupply = 10000;
    mapping(address => Payment[]) public userPayments;

    struct Payment {
        uint amount;
        address recipient;
    }

    constructor() {
        _mint(msg.sender, initialSupply);
    }
    event NewSupply(uint);
    event Transfer(address indexed, uint);

    function increaseTotalSupply(uint _quantity) public onlyOwner {
        _mint(msg.sender, _quantity);
        emit NewSupply(_quantity);
    }
    function transfer(address _recipient, uint _amount) public virtual override returns(bool) {
        _transfer;
        updatePaymentRecord(_recipient, msg.sender, _amount);
        return true;
    }
    function updatePaymentRecord(address _recipient, address _sender, uint _amount) private{
        Payment memory newPayment;
        newPayment.amount = _amount;
        newPayment.recipient = _recipient;
        userPayments[_sender].push(newPayment);
    }

    function getPayments(address _user) public view returns (Payment[] memory) {
        return userPayments[_user];
    }


}