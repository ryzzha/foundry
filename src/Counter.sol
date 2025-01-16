// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    event Incremented(uint indexed number, address indexed sender);

    modifier onlyOwner() {
        require(msg.sender == owner, "not an owner");
        _;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public onlyOwner {
        number++;
        emit Incremented(number, msg.sender);
    }
}
