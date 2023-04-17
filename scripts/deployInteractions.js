const hre = require("hardhat");

async function main() {
  console.log("deploying...");
  const Interactions = await hre.ethers.getContractFactory("Interactions");
  const interactions = await Interactions.deploy(
    "0x0496275d34753A48320CA58103d5220d394FF77F"
  );

  await interactions.deployed();

  console.log(
    "MarketInteractions loan contract deployed: ",
    interactions.address
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});