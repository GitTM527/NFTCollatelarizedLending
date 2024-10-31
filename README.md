[![Mentioned in Awesome Foundry](https://awesome.re/mentioned-badge-flat.svg)](https://github.com/crisgarner/awesome-foundry)

# NFT COLLATERALIZED LENDING PLATFORM
The NFT Collateralized Lending Platform is a Decentralized platform that allows users to collateralize their NFTs, borrow against their value, and retrieve their assets by repaying the loans. This contract-based system leverages Chainlink oracles and ERC-721 standard for NFT interoperability.

# Table of Content
* Overview
* Features
* Diamond Standard Implementation
* Smart Contract Components
* Oracle Integration
* Installation
* Contributing
* License

## Overview
The NFT Collateralized Lending Platform is designed to help users access funds by putting up their NFTs as collateral. Built on Ethereum, it offers a streamlined way to borrow against the value of digital assets. With the Diamond Standard, each contract component can be upgraded individually, ensuring flexibility and scalability as the platform grows.

## Features
* **NFT Collateralization:** Lock up NFTs and get access to loans in ETH or supported tokens.
* **Flexible Loan Terms:** Set loan amounts, interest rates, and durations based on your needs.
* **Real-time NFT Pricing:** Integrated Chainlink oracles for accurate collateral valuation.
* **Collateral Liquidation:** Automatic liquidation for overdue loans.
* **Modular Design with Diamond Standard:** Flexible upgrades and easy maintenance.

## Diamond Standard Details
The Diamond Standard (EIP-2535) lets us package the platform’s functionality into “facets” within a single contract.

* **Diamond Proxy:** The main contract for delegating to facets, this contract holds the data of the System and performs call to  the facets using the Low-Level EVM (delegate) calls.
* **Selectors:** Maps function selectors to facets.
* **Facets:** Contracts that handle a specific set of tasks (like collateral or loan management). This contracts defines the implemetation Logic of the contract (platform)

## Smart Contract Components
1. **Collateral Management Facet:** This Facet locks NFTs as collateral and handles their release or liquidation.
**Main Functions:**
**lockNFT():** Locks the NFT as loan collateral.
**releaseNFT():** Returns the NFT after loan repayment.
**liquidateNFT():** Liquidates NFT in case of default.

2. **Oracle Facet:** This facet is set to interacts with Chainlink oracles to fetch real-time NFT prices.
**Main Functions:**
**setNFTPrice():** This sets the price of an NFT,
**getNFTValue():** Returns the latest price of an NFT.
**calculateCollateralValue():** This function calculate/updates the value of the NFT against a collateral price.

3. **Loan Management Facet:** This facet manages loan creation, repayment, and tracking.
**Main Functions:**
**createLoan():** Starts a new loan.
**repayLoan():** Handles loan repayments.
**checkLoanStatus():** Checks the status of a loan.

4. **Interest Rate Management Facet:** This Facet implements thevLogic that calculates and updates loan interest rates.
**Main Functions:**
**calculateInterest():** Calculates interest for each loan.
**setBaseInteresRate():** Allows updates to interest rates.

5. **Governance Facet:** This facet controls platform governance and permissions.
**Main Functions:**
**createProposal():** Adds new users with permissions.
**vote():** Allows proposing changes to platform settings.

## Oracle Integration
The platform uses Chainlink oracles to fetch up-to-date pricing information, which helps determine loan values for NFTs. The Chainlink integration makes sure that collateral is accurately valued when you borrow or repay.

### How it Works:
Configure Chainlink as a pricing data source.
Use AggregatorV3Interface for price data.
Include error handling for oracle or network issues.


## Installation

- Clone this repo
- Install dependencies

```bash
$ yarn && forge update
```

### Compile

```bash
$ npx hardhat compile
```

## Deployment

### Hardhat

```bash
$ npx hardhat run scripts/deploy.js
```

### Foundry

```bash
$ forge t
```

## Contributing
We welcome contributions! Here’s how to get started:

1. Fork the repository and create a new branch.
2. Make your changes.
3. Open a pull request with a summary of your changes.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.


`Note`: A lot of improvements are still needed so contributions are welcome!!

Bonus: The [DiamondLoupefacet](contracts/facets/DiamondLoupeFacet.sol) uses an updated [LibDiamond](contracts/libraries//LibDiamond.sol) which utilises solidity custom errors to make debugging easier especially when upgrading diamonds. Take it for a spin!!

Need some more clarity? message me [on twitter](https://twitter.com/Akhuemartins), Or join the [EIP-2535 Diamonds Discord server](https://discord.gg/kQewPw2)
