pragma solidity >=0.4.21 <0.6.0;

 import './ERC721Mintable.sol';
 import './zokrates/code/square/verifier.sol';
 

// TODO define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
 contract SquareVerifier is Verifier{

 }

// TODO define another contract named SolnSquareVerifier that inherits ERC721Mintable

contract SolnSquareVerifier is  CustomERC721Token {
 // TODO define a solutions struct that can hold index, address, and image
struct Solution{
   string index;
   address solutionsAddress;
   string image;
  }

// TODO define an array of the above struct
  address[] private solutions;   
  
  // TODO define a mapping to store unique solutions submitted
  mapping(address => Solution) public SolutionStored;

// TODO Create an event to emit when a solution is added
  event solutionAdded(address _solution);


  // TODO Create a function to add the solutions to the array and emit the event
    function AddSoutions(address _solution) public{
     
      solutions.push(_solution);
      emit  solutionAdded(_solution);
    }

  // TODO Create a function to mint new NFT only after the solution has been verified
  //  - make sure the solution is unique (has not been used before)
  //  - make sure you handle metadata as well as tokenSuplly
  function mint(address _solution,uint256 tokenSuplly)public {
             require(_solution == SolutionStored[_solution].solutionsAddress);              
              mint(_solution,tokenSuplly);
  }
}

 







  







  


























