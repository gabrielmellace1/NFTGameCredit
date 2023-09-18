const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  // Compile the contracts
  await hre.run("compile");

  // Fetch current gas price from the network
  let gasPrice = await ethers.provider.getGasPrice();
  
  // Increase the gas price by a factor (e.g., multiplying by 2)
  gasPrice = gasPrice.mul(2);

  // Deploy the contract with the increased gas price
  const NFTCredit = await ethers.getContractFactory("NFTCredit");
  const name = "NFTCredit";
  const symbol = "NFTCredit";

  const nftcredit = await NFTCredit.deploy(name, symbol, {
    gasPrice: gasPrice
  });

  await nftcredit.deployed();
  console.log("NFTCredit deployed to:", nftcredit.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
