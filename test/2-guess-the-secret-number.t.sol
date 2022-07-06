// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/2-Guess-the-secret-number.sol";

// aqui puedes agregar un contrato o hacer otro import

contract Challenge2Test is Test {
    GuessTheSecretNumberChallenge target;
    address player = vm.addr(1);

    function setUp() public {
        target = new GuessTheSecretNumberChallenge{value: 1 ether}();
        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
        vm.deal(player, 1 ether);
    }

    function testChallenge() public {
        bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;
        vm.startPrank(address(player));
        
        // Tu codigo aqui

        assertTrue(target.isComplete());
    }
}
