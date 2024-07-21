const hre = require("hardhat");
describe("HelloWorld", function () {
    let helloWorldContract;
    before(async () => {
        // ⽣成合约实例并且复⽤ 
        helloWorldContract = await hre.ethers.deployContract("HelloWorld", []);
        
    });

    it('step1',async function () {
        // assert that the value is correct 
        // expect(await helloWorldContract.greet()).to.equal("Pending");
        console.log("result " + await helloWorldContract.greet());
    });
    // async () => {
    //     // ⽣成合约实例并且复⽤ 
    //     helloWorldContract = await hre.ethers.deployContract("HelloWorld", []);
        

    //     console.log("before done" + helloWorldContract.greet);
    //     console.log(await helloWorldContract.greet);
    // }
    
});