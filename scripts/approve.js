const { ethers } = require("hardhat");

async function main() {
    const Swap = await ethers.getContractFactory("Swap");

    const swap = Swap.attach(process.env.SWAP_ADDRESS);

    await swap.approveIOTX('0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
}

main();
