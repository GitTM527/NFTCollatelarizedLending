// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../../lib/chainlink-brownie-contracts/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract OracleFacet {
    // Mapping from NFT collection addresses to Chainlink price feed addresses
    mapping(address => address) public priceFeeds;
    // address public owner;

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "Not authorized");
    //     _;
    // }

    // constructor() {
    //     owner = msg.sender;
    // }

    /**
     * @dev Set or update the Chainlink price feed for a specific NFT collection
     * @param nftAddress The address of the NFT collection
     * @param feedAddress The address of the Chainlink price feed for this collection
     */
    function setPriceFeed(address nftAddress, address feedAddress) external  {
        priceFeeds[nftAddress] = feedAddress;
    }

    /**
     * @dev Get the latest price of the specified NFT collection
     * @param nftAddress The address of the NFT collection
     * @return price The latest price of the NFT collection
     */
    function getNFTPrice(address nftAddress) public view returns (uint256 price) {
        address feedAddress = priceFeeds[nftAddress];
        require(feedAddress != address(0), "Price feed not available");

        AggregatorV3Interface priceFeed = AggregatorV3Interface(feedAddress);
        (, int256 priceRaw, , , ) = priceFeed.latestRoundData();
        require(priceRaw > 0, "Invalid price data");

        // Assuming price has 8 decimals, scale to 18 decimals
        price = uint256(priceRaw) * 10**10;
    }

    /**
     * @dev Calculate the collateral value based on the latest NFT price and amount
     * @param nftAddress The address of the NFT collection
     * @param amount The quantity of NFTs used as collateral
     * @return collateralValue The calculated collateral value
     */
    function calculateCollateralValue(address nftAddress, uint256 amount) external view returns (uint256 collateralValue) {
        uint256 nftPrice = getNFTPrice(nftAddress);
        collateralValue = nftPrice * amount;
    }

    /**
     * @dev Allow the owner to remove a price feed
     * @param nftAddress The address of the NFT collection to remove the feed for
     */
    function removePriceFeed(address nftAddress) external {
        delete priceFeeds[nftAddress];
    }
}
