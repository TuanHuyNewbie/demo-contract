import { ethers } from "hardhat";

async function main() {
  let provider = new ethers.providers.JsonRpcProvider(
    "http://127.0.0.1:7545"
  );
  const TuanHuy = await ethers.getContractFactory("TuanHuy")
  const tuanHuy = TuanHuy.deploy("TUANHUY","THuy");
  (await tuanHuy).deployed()
  console.log("Success ", (await tuanHuy).address.toString());

  (await tuanHuy).mint("http://ipfs.io/ipfs/QmbE12GAYabhCAtwQQGJZKvkDXxQLNJYuAEFUmDKgfW5KR")
  
  console.log("Success NFT mint")

  /*const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  const lockedAmount = ethers.utils.parseEther("1");

  const Lock = await ethers.getContractFactory("Lock");
  const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  await lock.deployed();

  console.log(`Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`);*/
} 

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
});




