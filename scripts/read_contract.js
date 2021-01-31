const { ethers } = require("hardhat");

async function main() {
    const Swap = await ethers.getContractFactory("Swap");

    const swap = Swap.attach(process.env.SWAP_ADDRESS);

    const amounts = await swap.getAmountsOut('10000000000', [
        '0xd0A1E359811322d97991E03f863a0C30C2cF029C',
        '0x55111f7CB96f554746b6aE13270905792C242E7B'
    ]);

    console.log(amounts[0].toString());
    console.log(amounts[1].toString());
}

main();
