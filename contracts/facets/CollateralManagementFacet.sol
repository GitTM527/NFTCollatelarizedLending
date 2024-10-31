//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../interfaces/IERC721.sol";

contract CollateralManagementFacet {
   
    struct Collateral {
        address owner;
        uint256 loanAmount;
        bool isActive;
    }

    mapping(address => mapping(uint256 => Collateral)) public nftCollaterals;

    function lockNFT(address nftAddress, uint256 tokenId, uint256 loanAmount) external{
        IERC721(nftAddress).transferFrom(msg.sender, address(this), tokenId);
        nftCollaterals[nftAddress][tokenId] = Collateral(msg.sender, loanAmount, true);
    }

    function releaseNFT(address nftAddress, uint256 tokenId) external {
        Collateral storage collateral = nftCollaterals[nftAddress][tokenId];
        require(collateral.isActive, "collateral not active");
        require(collateral.owner == msg.sender, "not the owner");

        IERC721(nftAddress).transferFrom(address(this), msg.sender, tokenId);
        collateral.isActive = false;

    }

    function liquidateNFT (address nftAddress, uint256 tokenId) external {
        //liquidity function logic
    }
}