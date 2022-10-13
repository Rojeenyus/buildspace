const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.01"),
  });
  await waveContract.deployed();
  console.log(
    "Contract Balance: ",
    hre.ethers.utils.formatEther(
      await hre.ethers.provider.getBalance(waveContract.address)
    )
  );
  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);
  await waveContract.getTotalWaves();

  const tx = await waveContract.wave("hello!");
  await tx.wait();

  console.log(
    "Contract Balance: ",
    hre.ethers.utils.formatEther(
      await hre.ethers.provider.getBalance(waveContract.address)
    )
  );

  tx = await waveContract.wave("halluuu!");
  await tx.wait();

  console.log(
    "Contract Balance: ",
    hre.ethers.utils.formatEther(
      await hre.ethers.provider.getBalance(waveContract.address)
    )
  );

  await waveContract.getTotalWaves();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0); // exit Node process without error
  } catch (error) {
    console.log(error);
    process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
  }
  // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
};

runMain();
