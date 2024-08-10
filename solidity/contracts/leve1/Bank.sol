// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/**
msg
*/
contract Bank {
    // 状态变量
    address public immutable owner;

    //事件
    event Deposit(address _addr, uint256 _amt);
    event Withdraw(uint256 _amt);

    /*
    1，第一次部署合约 钱包地址存储的owner
    2，构造函数必须是 payable 的以便接收以太币
    */
    constructor() payable {
        owner = msg.sender;
    }
    
    //转账接收
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
        // 方法
    function withdraw() external {
        require(msg.sender == owner, "Not Owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }



    function getBalance() public view returns (uint256){
        return address(this).balance;
    }


}

/*
block：
包含了当前区块的信息。

常用的属性包括：

block.number：当前区块的编号。
block.timestamp：当前区块的时间戳（以秒为单位，自UNIX纪元起）。
block.difficulty：当前区块的挖矿难度。
block.gaslimit：当前区块的gas上限。
block.coinbase：当前区块的矿工地址（即挖出该区块的矿工）。
msg：
包含了与当前消息（通常是一个函数调用）相关的信息。

常用的属性包括：

msg.sender：发送消息的地址（即当前函数的调用者）。
msg.value：随消息发送的wei的数量（以wei为单位）。
msg.data：完整的调用数据（即函数的参数）。
msg.sig：调用数据的前四个字节（即函数的标识符或选择器）。
msg.gas：在发送交易时提供的gas量（注意：在Solidity 0.8.0及更高版本中，msg.gas已被弃用，应使用gasleft()函数）。
tx：
包含当前交易的信息。

常用的属性包括：

tx.origin：发送交易的原始地址（即交易的最终发起者，不考虑任何中间合约调用）。
tx.gasprice：交易的gas价格。
gasleft()：
这是一个函数，而不是一个变量，但它提供了关于剩余gas量的信息。
返回当前函数执行剩余的gas量。
now：
提供当前区块的时间戳（以秒为单位，自UNIX纪元起），相当于block.timestamp。
abi（注意：abi通常不被视为严格意义上的全局变量，因为它是一个用于ABI编码和解码的对象）：
提供了一组函数用于ABI的编码和解码。
包括abi.encode(...), abi.encodePacked(...), abi.encodeWithSelector(...), abi.encodeWithSignature(...), abi.decode(...)等函数。
*/