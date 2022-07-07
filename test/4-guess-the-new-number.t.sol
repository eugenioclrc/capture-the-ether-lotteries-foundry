// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/4-Guess-the-new-number.sol";

// aqui puedes agregar un contrato o hacer otro import

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

        // Tu codigo aqui
        
        assertTrue(target.isComplete());
    }
}