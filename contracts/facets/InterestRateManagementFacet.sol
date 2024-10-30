//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract InterestRateManagementFacet {
     
     uint256 public baseInterestRate = 5; // Example base rate of 5%

    function calculateInterest(uint256 principal, uint256 duration) external view returns (uint256) {
        return (principal * baseInterestRate * duration) / 100;
    }

    function setBaseInterestRate(uint256 newRate) external {
        baseInterestRate = newRate;
    }
}