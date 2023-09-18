NFTCredit Smart Contract & Subgraph Repository
This repository houses two primary projects:

NFTCredit Smart Contract: A unique Ethereum smart contract designed to facilitate the minting of NFTs in exchange for USDC payments.
Subgraph: A subgraph project to track and index events emitted by the NFTCredit smart contract, making it easier to query and retrieve data about transactions.
NFTCredit Smart Contract
Purpose:
The primary objective of the NFTCredit smart contract is to allow users to acquire NFTs by paying a specific amount in USDC. These NFTs represent a certain "credit" value, which can be used off-chain, for example, in a game or a platform. The smart contract ensures that:

Users can mint NFTs by paying in USDC.
The contract owner can mint special NFTs intended for secondary market sales.
NFT transfers are restricted to prevent users from misleading others about the off-chain credit value associated with the NFT.
Primary vs. Secondary Sales:
Primary Sales: When a user directly interacts with the smart contract to mint an NFT in exchange for USDC. This is the direct minting process.

Secondary Sales: These are sales that occur on marketplaces like OpenSea. The contract owner can mint special NFTs and list them on these marketplaces. When another user purchases one of these NFTs, they can transfer it once before it becomes non-transferable. This mechanism ensures that the NFT's off-chain credit value is honored and prevents misleading secondary sales.

Security:
To ensure the integrity of the system:

Transfers, approvals, and other ERC721 functions are overridden to enforce the rules of primary and secondary sales.
Only the contract owner can mint NFTs intended for secondary sales.
Events are emitted to track and verify off-chain credit awards.
Subgraph
Purpose:
The subgraph project is designed to track, index, and make it easy to query the events emitted by the NFTCredit smart contract. This ensures transparency and provides a reliable way to fetch data about the transactions.

Sample Query:
To retrieve the latest transactions under the CreditAcquired entities:

graphql: https://api.studio.thegraph.com/query/28179/nft-credit/version/latest

{
  creditAcquireds(orderBy: timestamp, orderDirection: desc, first: 10) {
    id
    to
    quantity
    creditAmount
    totalCreditAmount
    minted
    timestamp
  }
}