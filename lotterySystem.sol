pragma solidity >=0.4.22 <0.6.0;
contract Lottery{
    address payable []  public players;//arrya wiht players
    address payable public manager;//contract manager
    constructor() public{
        manager = msg.sender;
    }
    //will be automatically call when the contract is called
    function () external payable {
        require(msg.value>=0.01 ether);
        //called when sombody send ether
        players.push(msg.sender);
        //add the address of the account that sends the ether to the players
    
    }
    function get_balance() public view returns(uint){
        require(msg.sender==manager);
        return address(this).balance;//return
    }
    
    function random() public view returns(uint256){
        return uint256(uint256(keccak256(abi.encodePacked(block.timestamp))));
        
    }
    function selectWinner() public{
        require(msg.sender == manager);
        uint r = random();
        address payable winner ;
        winner =  (players[r%players.length]);
        //transfer contract balance to the winner address
        winner.transfer(address(this).balance);
        //resetting players array
        players = new address payable[](0);

    }
    
}
