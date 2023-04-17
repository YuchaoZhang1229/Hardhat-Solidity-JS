const { expect } = require('chai');
const { ethers } = require('hardhat');

describe("FlashLoan", () => {
  let flashloan
  let deployer

  beforeEach(async () => {
    // Setup accounts
    // accounts = await ethers.getSigners()
    // deployer = accounts[0]

    // Load contract 
    const FlashLoan = await ethers.getContractFactory('FlashLoan')
    // Deploy FlashLoan
    flashloan = await FlashLoan.deploy("0x0496275d34753A48320CA58103d5220d394FF77F")
    // await flashloan.deployed();


    // // Approve tokens before depositing
    // let transaction = await flashloan.connect(deployer).approve(flashLoan.address, 1)
    // await transaction.wait()

    // // Deposit tokens into the pool
    // transaction = await flashLoan.connect(deployer).depositUSDC(1)
    // await transaction.wait()
    


  })

  // describe("Deplyment"), ()=> {
  //   it('right owner', async()=>{
  //     expect(aw);
  //   })
  // }


});
