// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CarbonBurn {
    address public owner;
    uint256 public totalBurned;
    mapping(address => uint256) public userBurned;
    mapping(bytes32 => bool) public burnedProofs;

    event CarbonOffset(address indexed burner, uint256 amount, bytes32 proofHash);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function burnOffset(bytes32 proofHash) external payable {
        require(msg.value > 0, "Offset value must be greater than 0");
        require(!burnedProofs[proofHash], "Duplicate proof");

        burnedProofs[proofHash] = true;
        userBurned[msg.sender] += msg.value;
        totalBurned += msg.value;

        emit CarbonOffset(msg.sender, msg.value, proofHash);
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function getUserOffset(address user) external view returns (uint256) {
        return userBurned[user];
    }
}
