// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract TodoDemo{
    struct Todo{
        string name;
        bool isCompleted;
    }

    // 默认的存储模式是  storage
    Todo[] public todolist;

    function create(string memory _name) external {
        todolist.push(Todo({
            name : _name,
            isCompleted: false
        }));
    }


    /**
    修改任务名称
    法1: 直接修改，修改一个属性时候比较省 gas
    */
    function modifyName(uint256 _index, string memory _name) external {
        todolist[_index].name = _name;
    }

    /**
    修改任务名称
    方法2: 先获取储存到 storage，在修改，在修改多个属性的时候比较省 gas
    */
    function modifyNameV2(uint256 _index, string memory _name) external {
        // 临时变量存储 需要修改并且永久存储，需要 storage
        Todo storage temp = todolist[_index];
        temp.name = _name;
    }

    //修改完成状态1:手动指定完成或者未完成
    function modifyStatus(uint256 _index, bool status) external {
        require(todolist.length >= _index);
        todolist[_index].isCompleted = status;
    }
    // 修改完成状态2:自动切换 toggle
    function modifyStatusV2(uint256 _index) external {
        todolist[_index].isCompleted = !todolist[_index].isCompleted;
    }


    function getV1(uint256 _index) external view 
        returns (string memory _name, bool status){
        Todo memory temp = todolist[_index];
        return (temp.name, temp.isCompleted);
    }

    function getV2(uint256 _index) external view 
        returns (string memory _name, bool status){
        Todo storage temp = todolist[_index];
        return (temp.name, temp.isCompleted);
    }
}