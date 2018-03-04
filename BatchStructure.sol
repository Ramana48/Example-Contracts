pragma solidity ^0.4.16;

/* Batch Structure*/

contract BatchStructure
{
    address admin;
  
    
    struct BatchStructureDetails
    {
        uint productId;
        string productType;
        uint productQuantity;
        string productCreatedBy;
        uint productTimeStamp;
        
    }
    mapping (uint => BatchStructureDetails) batchStructureDetails;
    
    function BatchStructure() public
    {
        admin=msg.sender;
    }
    
    event printLog(string _by);
    
    modifier onlyAdmin(){
        if(msg.sender != admin)
        revert();
        _;
    } 
    
    function createBatchStructure(uint _productId, string _productType,uint _productQuantity,string _productCreatedBy) public onlyAdmin
    {
        if(batchStructureDetails[_productId].productId != 0){
            revert();
        }
        
        BatchStructureDetails memory newBatch;
        
        newBatch.productId = _productId;
        newBatch.productType = _productType;
        newBatch.productQuantity = _productQuantity;
        newBatch.productCreatedBy = _productCreatedBy;
        newBatch.productTimeStamp = now;
        
        batchStructureDetails[_productId] = newBatch;
        
        printLog(_productCreatedBy);
    }
    
    function updateBatchStructure(uint _productId, uint _productQuantity) public onlyAdmin
    {
        if(batchStructureDetails[_productId].productId == 0){
            revert();
        }
        
        
        BatchStructureDetails memory tempBatch = batchStructureDetails[_productId];
        
        
        tempBatch.productQuantity = _productQuantity;
        
        batchStructureDetails[_productId] = tempBatch;
    }
    
    
    function getProductBatchStructure(uint _productId) public view returns (string, uint,string,uint )
    {
        BatchStructureDetails memory tempBatch = batchStructureDetails[_productId];
        
        return (tempBatch.productType, tempBatch.productQuantity, tempBatch.productCreatedBy,tempBatch.productTimeStamp);
    }
     
}