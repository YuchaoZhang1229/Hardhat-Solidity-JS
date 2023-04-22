FlashLoan Contract Deployed:

0xCe48E8010caE5000d7B4630418f8dd4433646749

```
npx hardhat run --network sepolia scripts/deployFlashLoan.js
```

New: 0xFF0363E7A52B89966259598af31e402CD940cd65



Dex Contract Deployed:

0x8A6743Ab2807ffc70Afd8e804bfD362E111D4CA5

```
npx hardhat run --network sepolia scripts/deployDex.js
```

FlashLoanArbitage Contract Deployed:

0x1BE985E5bdf6A96B12eB69a40caaC793e5D2Dd07

```
npx hardhat run --network sepolia scripts/deployFlashLoanArbitrage.js
```

1. Add liquidity

- DAI 1500	

- USDC 1500

2. Approve

- DAI 1200000000000000000000
- USDC 10000000000

3. Request Loan - USDC (6 decimal)

- 0xda9d4f9b69ac6C22e444eD9aF0CfC043b7a7f53f, 1000000000 // 1000 USDC
- 赚了110 USDC



**AAVE IPoolAddressProvider (Sepolia):**

0x0496275d34753A48320CA58103d5220d394FF77F

**DAI-TestnetMintableERC20-Aave token (Sepolia):**

0x68194a729C2450ad26072b3D33ADaCbcef39D574

**USDC-TestnetMintableERC20-Aave token(Sepolia):**

0xda9d4f9b69ac6C22e444eD9aF0CfC043b7a7f53f



![image-20230411223537906](C:\Users\user\AppData\Roaming\Typora\typora-user-images\image-20230411223537906.png)

![image-20230411223627456](C:\Users\user\AppData\Roaming\Typora\typora-user-images\image-20230411223627456.png)



![image-20230412031209716](C:\Users\user\AppData\Roaming\Typora\typora-user-images\image-20230412031209716.png)

![image-20230412031229054](C:\Users\user\AppData\Roaming\Typora\typora-user-images\image-20230412031229054.png)

# Hardhat

https://hardhat.org/hardhat-runner/docs/getting-started#quick-start

1. 安装

```
npm init -y
npm install --save-dev hardhat
```

2. 创建hardhat项目

```
npx hardhat
```

![image-20230316211438096](C:\Users\user\AppData\Roaming\Typora\typora-user-images\image-20230316211438096.png)

3. 下载 Hardhat Toolbox plugin 依赖包

```
npm install --save-dev "hardhat@^2.13.1" "@nomicfoundation/hardhat-toolbox@^2.0.0"
```

https://hardhat.org/hardhat-runner/plugins/nomicfoundation-hardhat-toolbox

4. 编译和测试

```
// 编译
npx hardhat compile
// 测试
npx hardhat test test/my-tests.js
```

5. 部署

- 本地

```
npx hardhat node

npx hardhat run --network localhost scripts/deploy.js
```

- goerli

```
npx hardhat run --network goerli scripts/deployFlashLoan.js
```

# AAve

## Flash Loan

![image-20230411142033552](C:\Users\user\AppData\Roaming\Typora\typora-user-images\image-20230411142033552.png)

```
npm i @aave/core-v3 dotenv
```









## Liquidity Pool

![image-20230412140807041](C:\Users\user\AppData\Roaming\Typora\typora-user-images\image-20230412140807041.png)

**AAVE IPoolAddressProvider (Sepolia):**

0xE791BE6e526374bD696C7bFB634F9E940BAda167

**MarketInteractions Contract Deployed :** 

0x55107440618a9e57C85E5f2CA2A054C247416106

```
npx hardhat run --network sepolia scripts/deployMarketInteractions.js
```

18 decimal

**aLINK**: 0xD21A6990E47a07574dD6a876f6B5557c990d5867

**LINK**: 0x8a0E31de20651fe58A369fD6f76c21A8FF7f8d42

**Pool address**: 0xE7EC1B0015eb2ADEedb1B7f9F1Ce82F9DAD6dF08

**Contract address**: 0x55107440618a9e57C85E5f2CA2A054C247416106

MarketInteractions → Pool



Approve // 1000 Link

1000 000000000000000000, 0xE7EC1B0015eb2ADEedb1B7f9F1Ce82F9DAD6dF08 



Allowance 

0xE7EC1B0015eb2ADEedb1B7f9F1Ce82F9DAD6dF08 



Supply

0x8a0E31de20651fe58A369fD6f76c21A8FF7f8d42, 500000000000000000000









New

Contract: 0x0Ad719627f9CCCfc46b854cCa4297556216776c8

link: 0x8a0E31de20651fe58A369fD6f76c21A8FF7f8d42

alink: 0xD21A6990E47a07574dD6a876f6B5557c990d5867

# Test

https://www.youtube.com/watch?v=H-yL6nloq3I

nomic fundation



https://www.youtube.com/watch?v=9Qpi80dQsGU



# Bank

https://www.youtube.com/watch?v=lZMvP7ILDSg

# 上传github

```
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/YuchaoZhang1229/Hardhat-Solidity.git
git push -u origin main
```



# 最终合约部署

Market

0xaeA3A6C8Fac7E59680115504a682b49404c37CbB

