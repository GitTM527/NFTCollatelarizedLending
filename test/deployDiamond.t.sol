// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../contracts/interfaces/IDiamondCut.sol";
import "../contracts/facets/DiamondCutFacet.sol";
import "../contracts/facets/DiamondLoupeFacet.sol";
import "../contracts/facets/OwnershipFacet.sol";
import "../contracts/Diamond.sol";
import "../contracts/facets/CollateralManagementFacet.sol";
import "../contracts/facets/GovernmentFacet.sol";
import "../contracts/facets/InterestRateManagementFacet.sol";
import "../contracts/facets/LoanManagementFacet.sol";
import "../contracts/facets/OracleFacet.sol";

import "./helpers/DiamondUtils.sol";

contract DiamondDeployer is DiamondUtils, IDiamondCut {
    //contract types of facets to be deployed
    Diamond diamond;
    DiamondCutFacet dCutFacet;
    DiamondLoupeFacet dLoupe;
    OwnershipFacet ownerF;

    function testDeployDiamond() public {
        //deploy facets
        dCutFacet = new DiamondCutFacet();
        diamond = new Diamond(address(this), address(dCutFacet));
        dLoupe = new DiamondLoupeFacet();
        ownerF = new OwnershipFacet();
        collatF = new CollateralManagementFacet();
        govtF = new GovernmentFacet();
        interestF = new InterestRateManagementFacet();
        oracleF = new OracleFacet();

        //upgrade diamond with facets

        //build cut struct
        FacetCut[] memory cut = new FacetCut[](6);

        cut[0] = (
            FacetCut({
                facetAddress: address(dLoupe),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("DiamondLoupeFacet")
            })
        );

        cut[1] = (
            FacetCut({
                facetAddress: address(ownerF),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("OwnershipFacet")
            })
        );

        cut[2] = (
            FacetCut({
                facetAddress: address(collatF),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("CollateralManagementFacet")
            })
        );

        cut[3] = (
            FacetCut({
                facetAddress: address(govtF),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("GovernmentFacet")
            })
        );

         cut[4] = (
            FacetCut({
                facetAddress: address(interestF),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("InterestRateManagementFacet")
            })
        );

        cut[5] = (
            FacetCut({
                facetAddress: address(oracleF),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("OracleFacet")
            })
        );

        //upgrade diamond
        IDiamondCut(address(diamond)).diamondCut(cut, address(0x0), "");

        //call a function
        DiamondLoupeFacet(address(diamond)).facetAddresses();
    }

    function diamondCut(
        FacetCut[] calldata _diamondCut,
        address _init,
        bytes calldata _calldata
    ) external override {}
}
