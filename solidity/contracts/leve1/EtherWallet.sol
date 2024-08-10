// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract EtherWallet{
    address payable public immutable owner;
    event Log(string funName, address from, uint256 value, bytes data);

    // 设置合约的部署者为 所有者
    constructor() {
        owner = payable (msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
     }

     function withdraw1() external onlyOwner{
        payable(msg.sender).transfer(100);
     }

     function withdraw2() external onlyOwner{
        bool success = payable(msg.sender).send(200);
     }

     function withdraw3() external onlyOwner {
        (bool success,) = msg.sender.call{value: address(this).balance}("");
     }

    function getBalance() external view returns(uint256){
        return address(this).balance;
    }
}