// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract WETH{
    string public name = "Wrapped Ether";
    string public symbol = "WETH";
    uint8 public decimals = 18;
    event Approval(address indexed src, address indexed delegateAds, uint256 amount);
    
    /**
    转账 
    indexed 修饰事件时，将参数作为topic存储
    */
    event Transfer(address indexed src, address indexed toAds, uint256 amount);
    /**
    存钱
    */
    event Deposit(address indexed  toAds, uint256 amount);
    
    /**
    取款
    */
    event Withdraw(address indexed src, uint256 amount);

    // 指定地址的 Token 数量
    mapping (address => uint256) public balanceOf;
    // 指定地址对另外一个地址的剩余授权额度
    mapping (address =>mapping (address =>uint256)) public allowance;

    //吧存款记录到 balanceOf
    function desposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    //取款 对应账户地址需要扣除提现金额，
    function withdraw(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    //查询当前合约的 Token 总量, 来源于用户提现抵押的token数量
    function totalSupply() public view returns (uint256){
        return address(this).balance;
    }

    function approve(address delegateAds, uint256 amount) public returns (bool) {
        allowance[msg.sender][delegateAds] = amount;
        emit Approval(msg.sender, delegateAds, amount);
        return true;
    }

    function transfer(address toAds, uint256 amount) public returns (bool){
        return transferForm(msg.sender, toAds, amount);
    }

    function transferForm(address src, address toAds, uint256 amount) public returns (bool) {
        require(balanceOf[src] >= amount);
        if(src != msg.sender){
            require(allowance[src][msg.sender] >= amount);
            allowance[src][msg.sender] -= amount;
        }
        balanceOf[src] -=amount;
        balanceOf[toAds] += amount;
        emit Transfer(src, toAds, amount);
        return true;
    }

    fallback() external payable {
         desposit();
    }

    //合约接收存款
    receive() external payable {
         desposit();
    }
}