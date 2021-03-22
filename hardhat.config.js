require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    version: "0.6.8",
    optimizer: {
      enabled: true,
      runs: 1000
    }
  },
  networks: {
    hardhat: {
      accounts: {
        count: 200,
      }
    },
    mainnet: {
      url: `https://mainnet.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
      throwOnTransactionFailures: true,
      throwOnCallFailures: false
    },
    kovan: {
      url: `https://kovan.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
      throwOnTransactionFailures: true,
      throwOnCallFailures: false
    },
    bsc: {
      url: `https://bsc-dataseed.binance.org`,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
      throwOnTransactionFailures: true,
      throwOnCallFailures: false
    },
    bsc_test: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545`,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
      throwOnTransactionFailures: true,
      throwOnCallFailures: false
    }
  },
  etherscan: {
    apiKey: `${process.env.ETHERSCAN_API_KEY}`,
  }
};

