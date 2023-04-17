require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.10",
  networks: {
    goerli:{
      //url: process.env.INFURA_GOERLI_ENDPOINT,
      //accounts: process.env.PRIVATE_KEY,
      url: "https://goerli.infura.io/v3/d6b6084b847840e4970c563e569200d4",
      accounts:["3d9ec9cc0c837699f3b4e80372a54f4604f2f52794c1cc1b7df190abda7b4290"],
    },

    sepolia:{
      //url: process.env.INFURA_GOERLI_ENDPOINT,
      //accounts: process.env.PRIVATE_KEY,
      url: "https://sepolia.infura.io/v3/d6b6084b847840e4970c563e569200d4",
      accounts: ["3d9ec9cc0c837699f3b4e80372a54f4604f2f52794c1cc1b7df190abda7b4290"],
    }
  }
};

