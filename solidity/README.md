# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```

```
mkdir learning-web3/solidity
cd learning-web3/solidity
npm init
npm install --save-dev hardhat
npx hardhat init 
-- select create a JavaScript project

```
开发完成后，编译
```
npx hardhat compile
```

### 部署合约
1， 启动本地网络
```
npx hardhat node
```
2，部署合约
```
npx hardhat ignition deploy ./ignition/modules/Lock.js --network localhost
```