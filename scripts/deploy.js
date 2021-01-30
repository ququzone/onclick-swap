
const { ethers } = require("hardhat");

async function main() {
    const Swap = await ethers.getContractFactory("Swap");

    const swap = await Swap.deploy(
        process.env.WETH_ADDRESS,
        process.env.IOTX_ADDRESS,
        process.env.FACTORY_ADDRESS,
        process.env.TUBE_ADDRESS,
    );
    await swap.deployed();
    console.log("Swap deployed to:", swap.address);
}

main();
