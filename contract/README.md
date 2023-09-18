NFTCredit Smart Contract
Overview
The NFTCredit smart contract is designed to facilitate the purchase of in-game credits using NFTs. The contract allows users to mint NFTs in exchange for USDC, which represents a certain amount of in-game credits. Additionally, the contract supports secondary sales of NFTs by authorized resellers.

Features
Minting NFTs: Users can mint NFTs by sending the appropriate amount of USDC to the contract. The minted NFT represents a certain amount of in-game credits.

Secondary Sales: The contract owner can mint special NFTs intended for secondary sales on platforms like OpenSea. These NFTs can be transferred once by the buyer, after which they are locked to prevent further transfers.

Authorized Resellers: Only addresses in the authorizedResellers list can initiate transfers of NFTs. This ensures that only trusted entities can sell NFTs on secondary markets.

Events: The contract emits events to notify off-chain systems of important actions, such as the minting of an NFT or a successful transfer. These events can be used to award in-game credits to users.

Security: The contract includes various security measures, such as the prevention of unauthorized transfers and approvals.

Purpose
The primary purpose of the NFTCredit contract is to allow users to purchase in-game credits using USDC. When a user mints an NFT, they are essentially buying in-game credits. The amount of credits is represented by the NFT and can be determined by off-chain systems by listening to contract events.

Additionally, the contract supports secondary sales by allowing the contract owner to mint special NFTs. These NFTs can be listed on platforms like OpenSea. When a user buys one of these NFTs, they are also buying in-game credits. The contract ensures that these NFTs can only be transferred once to prevent users from reselling them.

How It Works
Minting: A user sends USDC to the contract and specifies the amount of in-game credits they wish to purchase. The contract mints an NFT representing the purchased credits and sends it to the user.

Secondary Sales: The contract owner can mint special NFTs and list them on secondary markets. When a user buys one of these NFTs, they can transfer it once to their own address. After this, the NFT is locked and cannot be transferred again.

Awarding Credits: Off-chain systems can listen to contract events to determine when a user has purchased credits. When the contract emits an event indicating that an NFT has been minted or transferred, the off-chain system can award the corresponding amount of in-game credits to the user.