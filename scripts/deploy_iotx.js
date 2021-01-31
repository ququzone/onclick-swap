const { ethers } = require("hardhat");

async function main() {
    const ERC20Mock = await ethers.getContractFactory("ERC20Mock");

    const iotx = await ERC20Mock.deploy("IOTX token", "IOTX", 18, "10000000000000000000000");
    await iotx.deployed();
    console.log("IOTX deployed to:", iotx.address);
}

main();
