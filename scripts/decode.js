const { ethers } = require("hardhat");

const ABI = [
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "amountOutMin",
        "type": "uint256"
      },
      {
        "internalType": "address[]",
        "name": "path",
        "type": "address[]"
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "deadline",
        "type": "uint256"
      }
    ],
    "name": "swapExactETHForTokens",
    "outputs": [
      {
        "internalType": "uint256[]",
        "name": "amounts",
        "type": "uint256[]"
      }
    ],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "amountIn",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "amountOutMin",
        "type": "uint256"
      },
      {
        "internalType": "address[]",
        "name": "path",
        "type": "address[]"
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "deadline",
        "type": "uint256"
      }
    ],
    "name": "swapExactTokensForTokens",
    "outputs": [
      {
        "internalType": "uint256[]",
        "name": "amounts",
        "type": "uint256[]"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  }
]

async function main() {
  const inter = new ethers.utils.Interface(ABI);

  let result = inter.decodeFunctionData('0x7ff36ab5', '0x7ff36ab500000000000000000000000000000000000000000000013a3b8814b8bb29f9c800000000000000000000000000000000000000000000000000000000000000800000000000000000000000008a3d6c8ad3c676ae9d72ebc473e854f6a0614a0600000000000000000000000000000000000000000000000000000000600b56cc0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000c02aaa39b223fe8d0a0e5c4f27ead9083c756cc20000000000000000000000006fb3e0a217407efff7ca062d46c26e5d60a14d69');
  console.log(inter.getFunction('0x7ff36ab5').name);
  console.log(`amount: ${result.amountOutMin.toString()}`);
  console.log(`path: ${result.path}`);
  console.log(`to: ${result.to}`);
  console.log(`deadline: ${result.deadline}`);
  
  console.log('\n');

  result = inter.decodeFunctionData('0x38ed1739', '0x38ed17390000000000000000000000000000000000000000000000000000000005f5e1000000000000000000000000000000000000000000000002002978860f2a36b5b600000000000000000000000000000000000000000000000000000000000000a00000000000000000000000008a3d6c8ad3c676ae9d72ebc473e854f6a0614a0600000000000000000000000000000000000000000000000000000000600dbc2c0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec70000000000000000000000006fb3e0a217407efff7ca062d46c26e5d60a14d69');
  console.log(inter.getFunction('0x38ed1739').name);
  console.log(`amount: ${result.amountOutMin.toString()}`);
  console.log(`path: ${result.path}`);
  console.log(`to: ${result.to}`);
  console.log(`deadline: ${result.deadline}`);
}

main();
