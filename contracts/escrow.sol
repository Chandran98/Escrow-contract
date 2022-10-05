// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract Escrow{
    address public owner;

    constructor(){
        owner =msg.sender;
    }
struct Holders{
    string name;
    uint releasetime;
    uint amount;
    bool withdrawal;
    address payable walletaddress;
}

  Holders[] public holders;



  function addshareholders(string memory name,uint releasetime,uint amount,bool withdrawal,address payable walletaddress)public{
      holders.push(Holders(name,releasetime,amount,withdrawal,walletaddress));
  }
  
  function getindex(address walletaddress) private  view returns(uint){
      for(uint i=0;i<holders.length; i++){
          if(holders[i].walletaddress == walletaddress){
              return i;
          }
      }
              return 9999;
  }
  
  function deposit(address walletaddress,uint depositamount) public{
        Addfundsshareholders( walletaddress, depositamount);
  }
  
  function Addfundsshareholders(address walletaddress,uint depositamount)public  payable{
      for(uint i=0;i<holders.length;i++){
          if(holders[i].walletaddress==walletaddress){
              holders[i].amount+=depositamount;
          }
      }
  }  

  function avaiabletowithdraw(address walletaddress)public view returns(bool){
      uint i= getindex(walletaddress);
  if(block.timestamp==holders[i].releasetime){
        holders[i].withdrawal== true;
        return true;
  }else{
  holders[i].withdrawal== false;
  return false;
  }
  }

modifier onlyonwer{

      require(msg.sender==owner,"You're not the owner");
      _;
}

  function withdraw(address  walletaddress) payable public {
      uint i= getindex(walletaddress);
      require(msg.sender==holders[i].walletaddress,"You can withdraw this shares");

      require(holders[i].withdrawal==true,"You can't withdraw now");
      holders[i].walletaddress.transfer(holders[i].amount);
  }  
}


//Naruto,3241232314,450,ture,0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C

//Ushiwaka,324314,450,false,0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB

//Itachi,163432443,450,false,0xdD870fA1b7C4700F2BD7f44238821C26f7392148