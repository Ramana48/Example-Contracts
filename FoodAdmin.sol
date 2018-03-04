pragma solidity 0.4.*;

contract FoodAdmin
{
    address admin;
     function FoodAdmin()
    {
        admin=msg.sender;
    }
    
    modifier onlyadmin()
    {
        if(admin!=msg.sender)
        {
            revert();
        }
        _;
    }
    struct Suplier
    {
        address addr;
        string name;
    }
    mapping ( address=> Suplier ) suplier;
    
   function addSupplier(address _addr, string _name) onlyadmin
    {
        if(suplier[_addr].addr!=0)
        {
            revert();
        }
       Suplier storage tempSuplier;
        
        tempSuplier.addr=_addr;
        tempSuplier.name=_name;
        
        suplier[_addr]=tempSuplier;
    }
    
    function getSuplier(address _addr) view returns (string str)
    {
        return suplier[_addr].name;
    }
}