// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract SimpleCoin{
    /*Event*/
    event amountSent(address indexed from, address indexed to, uint256 amount); 

    /*Errors*/
    error notOwner(); 
    error notEnoughBalance(); 
    error ownAccount(); 

    /*State Variables*/
    mapping (address => uint256) private userBalance; 
    address private owner; 

    /*function*/
    constructor(){
        owner = msg.sender; 
    }

    function mint(address _userAddress, uint256 _amount) public{
        if(msg.sender != owner){
            revert notOwner(); 
        }
        userBalance[_userAddress] += _amount; 
    }

    function send(address _recieveAddress, uint256 _amount) public {
        require(userBalance[msg.sender] >= _amount, notEnoughBalance());
        require(msg.sender != _recieveAddress, ownAccount()); 
        userBalance[msg.sender] -= _amount; 
        userBalance[_recieveAddress] += _amount; 
        emit amountSent(msg.sender, _recieveAddress, _amount); 
    }
 
    /*Getters*/
    function getUserBalance(address _userAddress) public view returns(uint256){
        return userBalance[_userAddress]; 
    }

    function getOwner() public view returns(address){
        return owner; 
    }
}