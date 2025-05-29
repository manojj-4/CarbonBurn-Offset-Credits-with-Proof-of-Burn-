const hre = require("hardhat");

async function main() {
  const CarbonBurn = await hre.ethers.getContractFactory("CarbonBurn");
  const carbonBurn = await CarbonBurn.deploy();

  await carbonBurn.deployed();
  console.log("CarbonBurn contract deployed to:", carbonBurn.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
