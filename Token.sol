pragma solidity ^0.8.2;

contract Token{
    mapping (address => uint) public balances;
    mapping (address => mapping (address => uint)) public allowance;
    unit public totalSupply = 21000000 * 10 ** 18;
    string public name = "Aebi Sample Token";
    string public symbol = "ABI";
    unit public decimals = 18;
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    //executed only once when a smart contract is deployed
    constructor(){
        balances[msg.sender] = totalSupply;
    }
    
    //To read the balance of any address
    function balanceOf(address owner) public view returns(uint){
        return balances[owner];
    }
    
    //To transfer 'value' amount of tokens to 'to' address
    function transfer(address to, uint value) public returns(bool){
        require(balanceOf(msg.sender) >= value, 'balance too low');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    //Function to do delegated Transfer
    function transferFrom(address from, address to, uint value) public returns(bool){
        require(balanceOf(from) >= value, 'balance too low');
        require(allowance[from][msg.sender] >= value, 'allowance too low');
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }
    
    //This means that 'spender' can spend 'value' amount of tokens on behalf of 'msg.sender'
    function approve(address spender, uint value) public returns(bool){
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}