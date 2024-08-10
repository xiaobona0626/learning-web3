// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract BankERC721 {
    // 定义代币ID的计数器
    uint256 public _tokenIds;
    
    // 定义一个mapping，用于存储代币的URI
    mapping(uint256 => string) public tokenURI;
    
    // 定义一个mapping，用于存储代币的所有者
    mapping(uint256 => address) public ownerOf;

    // 构造函数，初始化合约
    constructor() {
        _tokenIds = 0;
    }

    // 存款功能：创建新的NFT，并分配给指定的地址
    function mint(address to, string memory uri) public returns (uint256){
        // 增加代币ID
        _tokenIds++;
        uint256 newItemId = _tokenIds;
        
        // 将新代币分配给指定地址
        ownerOf[newItemId] = to;
        
        // 设置代币的URI
        tokenURI[newItemId] = uri;
        
        // 触发Transfer事件，通知其他合约或用户该代币的所有权已更改
        emit Transfer(address(0), to, newItemId);
        
        return newItemId;
    }

    // 取款功能：销毁指定的NFT
    function burn(uint256 _tokenId) public {
        // 检查是否是合约的拥有者
        require(msg.sender == ownerOf[_tokenId], "Not owner");
        
        // 删除代币
        delete ownerOf[_tokenId];
        
        // 删除代币的URI
        delete tokenURI[_tokenId];
        
        // 触发Transfer事件，通知其他合约或用户该代币已被销毁
        emit Transfer(ownerOf[_tokenId], address(0), _tokenId);
    }

    // 转账功能：将指定代币的所有权转移给另一个地址
    function transfer(uint256 _tokenId, address to) public {
        // 检查代币是否存在
        require(exists(_tokenId), "Token does not exist");
        
        // 检查接收者地址是否为零地址
        require(to != address(0), "Cannot transfer to zero address");
        
        // 检查发送者是否是代币的当前拥有者
        require(msg.sender == ownerOf[_tokenId], "Not owner");
        
        // 转移代币的所有权
        ownerOf[_tokenId] = to;
        
        // 触发Transfer事件，通知其他合约或用户该代币的所有权已更改
        emit Transfer(ownerOf[_tokenId], to, _tokenId);
    }

    // 查询代币信息
    function exists(uint256 _tokenId) public view returns (bool) {
        return _tokenId <= _tokenIds;
    }

    // 查询代币URI
    function getTokenURI(uint256 _tokenId) public view returns (string memory) {
        return tokenURI[_tokenId];
    }

    // 查询代币所有者
    function getOwner(uint256 _tokenId) public view returns (address) {
        return ownerOf[_tokenId];
    }

    //ERC721标准的事件
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
}