//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract GovernmentFacet {

    struct Proposal {
        string description;
        uint256 voteCount;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;

    function createProposal(string memory description) external {
        uint256 proposalId = uint256(keccak256(abi.encode(description)));
        proposals[proposalId] = Proposal(description, 0, false);
    }

    function vote(uint256 proposalId) external {
        proposals[proposalId].voteCount += 1;
    }
}