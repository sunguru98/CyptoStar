require("dotenv").config();
const HDWalletProvider = require("truffle-hdwallet-provider");
const { INFURA_PROJECT_ID, MNEMONIC } = process.env;

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1", // Localhost (default: none)
      port: 7545, // Ganache CLI
      network_id: "*", // Any network (default: none)
    },

    rinkeby: {
      provider: () =>
        new HDWalletProvider(
          MNEMONIC,
          `https://rinkeby.infura.io/v3/${INFURA_PROJECT_ID}`
        ),
      network_id: 4, // Ropsten's id
      gas: 5500000, // Ropsten has a lower block limit than mainnet
      confirmations: 2, // # of confs to wait between deployments. (default: 0)
      timeoutBlocks: 200, // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true, // Skip dry run before migrations? (default: false for public nets )
    },
  },
  // Configure your compilers
  compilers: {
    solc: {
      version: "0.5.1",
    },
  },
};
