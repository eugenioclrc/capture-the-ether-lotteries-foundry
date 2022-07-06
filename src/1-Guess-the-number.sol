// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract GuessTheNumberChallenge {
    uint8 answer = 42;

    constructor() payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether, "Mas guita rata");

        if (n == answer) {
            payable(msg.sender).transfer(2 ether);
        }
    }
}
