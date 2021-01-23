const { ethers } = require("hardhat");

async function main() {
  const MockUniswapV2Router02 = await ethers.getContractFactory("MockUniswapV2Router02");

  const router = MockUniswapV2Router02.attach('0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D');

  // path: [ETH -> USDT -> IOTX]
  // 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,0xdAC17F958D2ee523a2206206994597C13D831ec7,0x6fB3e0A217407EFFf7Ca062D46c26E5d60a14d69
  const result = await router.getAmountsOut(
    ethers.utils.parseEther("0.05"),
    ['0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2', '0x6fB3e0A217407EFFf7Ca062D46c26E5d60a14d69']
  );

  console.log(`amount 1: ${result[0].toString()}`);
  console.log(`amount 2: ${result[1].toString()}`);
}

main();
