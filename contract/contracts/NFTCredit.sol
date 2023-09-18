// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTCredit is Ownable, ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    IERC20 public USDC_token = IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174);
    address public treasuryWallet = 0xEA5Fed1D0141F14DE11249577921b08783d6A360;


    uint256[] private allowedCredits = [1, 5, 10, 50, 100, 500, 1000];

    mapping(address => bool) public authorizedResellers;
    mapping(uint256 => uint256) public tokenCredits;

    event creditAcquired(address indexed to, uint256 quantity, uint256 creditAmount, uint256 totalCreditAmount, bool minted);

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    

    function mint(address to, uint256 quantity, uint256 creditAmount) external payable {
        require(isAllowedCredit(creditAmount), "Invalid credit amount");
        uint256 amountWithDecimals = creditAmount * 10**6 * quantity;
        require(USDC_token.transferFrom(msg.sender, treasuryWallet, amountWithDecimals), "Funds transfer unsuccessful");

        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = _tokenIdCounter.current();
            _safeMint(to, tokenId);
            _setTokenURI(tokenId, getTokenURIForCredit(creditAmount));
            tokenCredits[tokenId] = creditAmount;
            _tokenIdCounter.increment();
        }

        emit creditAcquired(to, quantity, creditAmount, creditAmount * quantity,true);
    }

    function mintSecondaryMarketNFT(address to, uint256 creditAmount) external onlyOwner {
        require(isAllowedCredit(creditAmount), "Invalid credit amount");
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, getTokenURIForCredit(creditAmount));
        tokenCredits[tokenId] = creditAmount;
        _tokenIdCounter.increment();
    }

    

    function approve(address to, uint256 tokenId) public override(ERC721, IERC721) {
        require(authorizedResellers[msg.sender], "Not authorized to approve");
        super.approve(to, tokenId);
    }

    function setApprovalForAll(address operator, bool approved) public override(ERC721, IERC721) {
        require(authorizedResellers[msg.sender], "Not authorized to set approval for all");
        super.setApprovalForAll(operator, approved);
    }

   function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public override(ERC721, IERC721) {
    // Check if the NFT is being held by an authorized reseller
    require(isAuthorizedReseller(from), "Only authorized resellers can initiate transfers");
    super.safeTransferFrom(from, to, tokenId, _data);
    emit creditAcquired(to, 1,  tokenCredits[tokenId],  tokenCredits[tokenId],false);
}

    function isAuthorizedReseller(address reseller) public view returns (bool) {
        return authorizedResellers[reseller];
    }

     function setResellerStatus(address reseller, bool status) external onlyOwner {
        authorizedResellers[reseller] = status;
    }

    function isAllowedCredit(uint256 credit) private view returns (bool) {
        for (uint256 i = 0; i < allowedCredits.length; i++) {
            if (credit == allowedCredits[i]) {
                return true;
            }
        }
        return false;
    }

    function getTokenURIForCredit(uint256 credit) private pure returns (string memory) {
        if (credit == 1) return "https://specificurl.com/token1usd.json";
        if (credit == 5) return "https://specificurl.com/token5usd.json";
        if (credit == 10) return "https://specificurl.com/token10usd.json";
        if (credit == 50) return "https://specificurl.com/token50usd.json";
        if (credit == 100) return "https://specificurl.com/token100usd.json";
        if (credit == 500) return "https://specificurl.com/token500usd.json";
        if (credit == 1000) return "https://specificurl.com/token1000usd.json";
        revert("Invalid credit amount");
    }

    function tokenURI(uint256 tokenId) public view override(ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function burn(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "You are not the owner of this token");
        _burn(tokenId);
    }

    function setTreasuryWallet(address newTreasuryWallet) external onlyOwner {
        treasuryWallet = newTreasuryWallet;
    }
}
