pragma solidity ^0.4.11;

contract Ownable {
  
  address public owner;

  event OwnershipTransferred(address indexed_previousOwner, address indexed_newOwner);

  function Ownable() public {
    owner = msg.sender;
  }

 // Modifier for Checking Ownership 
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

 //Changing Ownership
  function transferOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}
contract Lottery is Ownable{

    mapping(address => uint) usersLottery;
    mapping(uint => address) users;
    
    uint nbUsers = 0;
    uint totalBets = 0;
    address winnerAddress;
    event WinnerAddress(address winner);
   
    function Buy() public payable  {
        if (msg.value > 0) {
            
            if (usersLottery[msg.sender] == 0) {
                users[nbUsers] = msg.sender;
                nbUsers += 1;
            }
            
            usersLottery[msg.sender] += msg.value;
            totalBets += msg.value;
        }
    }
    
    function PicLottery() public  onlyOwner constant returns(address winnerAddress){
        
            // Minimum 3 users required to PicLottery
            if(nbUsers>=3)       
            {
                
            uint sum = 0;
            
            // Generating Random number 
            uint winningNumber = uint(block.blockhash(block.number-1)) % totalBets + 1;
            for (uint i=0; i < nbUsers; i++) 
              {
                sum += usersLottery[users[i]];
                if (sum >= winningNumber) 
                {
                    // Transfering funds to winner
                    users[i].transfer(totalBets);
                    winnerAddress=users[i];
                    WinnerAddress(users[i]);
                    
                    return users[i];
                }
              }
            }
        }
}