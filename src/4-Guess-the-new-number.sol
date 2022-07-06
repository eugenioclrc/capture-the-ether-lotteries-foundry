// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract GuessTheNewNumberChallenge {
    constructor() payable {
        require(msg.value == 1 ether, "You must pay 1 ether to play");
    }

    event log(uint256 answer);

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);
        uint8 answer = uint8(
            uint256(
                keccak256(
                    abi.encodePacked(blockhash(block.number - 1), block.timestamp)
                )
            )
        );

        emit log(answer);

        if (n == answer) {
            payable(msg.sender).transfer(2 ether);
        }
    }
}