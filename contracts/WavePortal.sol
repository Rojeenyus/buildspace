// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {address waver; string message; uint256 timestamp;}

    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s has Waved! With message %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp));
        uint256 prize = 0.0001 ether;
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Generate random number: %d", seed);
        
        if (seed > 50){
            console.log("you won addy: %s!", msg.sender);
            require(prize <= address(this).balance);
            (bool success, ) = (msg.sender).call{value: prize}("");
            require(success, "Failed to withdraw money");
        }
        
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns(Wave[] memory){
        return waves;
    }
    
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total Waves", totalWaves);
        return totalWaves;
    }
}