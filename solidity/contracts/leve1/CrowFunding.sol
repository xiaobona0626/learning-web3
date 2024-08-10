// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract CrowFunding {
    // 受益人
    address public immutable beneficiary;

    // 筹备目标数
    uint256 public immutable fundingGoal;

    //当前金额
    uint256 public fundingAmount;

    //捐赠人对应资金
    mapping (address => uint256) public funders;

    //捐赠人标签
    mapping (address => bool) private  fundersInserted;
    //统计捐赠人数量
    address[] public fundersKey;

    //任务状态
    bool public AVALIABLED = true;

    /**
    合约实例化需初始化  受益人 和 目标金额
    */
    constructor(address beneficiary_, uint256 goal_){
        beneficiary = beneficiary_;
        fundingGoal = goal_;
    }

    /***

    资助逻辑
    
    */
    function contribute() external payable {
        // 合约关闭之后不能操作
        require(AVALIABLED, "CrowFunding is closed");

        uint256 potentialFundingAmount = fundingAmount + msg.value;
        uint256 refundAmount = 0;

        if(potentialFundingAmount > fundingGoal){
            refundAmount = potentialFundingAmount - fundingGoal;
            funders[msg.sender] += (msg.value - refundAmount);

            fundingAmount += (msg.value - refundAmount);
        } else {
            funders[msg.sender] += msg.value;
            fundingAmount += msg.value;
        }

        if(!fundersInserted[msg.sender]){
            fundersInserted[msg.sender] = true;
            fundersKey.push(msg.sender);
        }

        if(refundAmount > 0){
            payable (msg.sender).transfer(refundAmount);
        }
    }

    function close() external returns (bool){
        if(fundingAmount < fundingGoal){
            return false;
        }
        uint256 amount = fundingAmount;

        fundingAmount = 0;
        AVALIABLED = false;

        payable (beneficiary).transfer(amount);
        return true;
    }

    function fundersLenght() public view returns (uint256){
        return fundersKey.length;
    }
}