const { ethers } = require("hardhat");

async function main() {
    const TubeMock = await ethers.getContractFactory("TubeMock");

    const tube = await TubeMock.deploy();
    await tube.deployed();
    console.log("Tube deployed to:", tube.address);
}

main();
