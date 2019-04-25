pragma solidity >=0.4.21 <0.6.0;


 import './Verifier.sol';
 import './ERC721Mintable.sol';

 



// TODO define another contract named SolnSquareVerifier that inherits ERC721Mintable

contract SolnSquareVerifier is  ERC721Mintable {

// TODO define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
Verifier verifier;
 // TODO define a solutions struct that can hold index, address, and image
struct Solution{
   uint256 id;
   address solutionsAddress;
  }
constructor(address _verifierContract) ERC721Mintable()  public{
verifier = Verifier(_verifierContract);
}
// TODO define an array of the above struct
  Solution[] private solutions;   
  
  // TODO define a mapping to store unique solutions submitted
  mapping(bytes32 => Solution) public solutionsSubmitted;

// TODO Create an event to emit when a solution is added
  event solutionAdded(address _solution);


  // TODO Create a function to add the solutions to the array and emit the event
    function addSolution(address _solutionAddress, uint256 _id, uint[2] memory A, uint[2][2] memory B,  uint[2] memory C, uint[2] memory input) public {
     	bytes32 key = keccak256(abi.encodePacked(A, B, C, input));
       	require(isSolutionUnique(key), "Solution already exsits.");
     Solution memory sol = Solution({id: _id, solutionsAddress: _solutionAddress});
        solutionsSubmitted[key] = sol;
      solutions.push(sol);
      emit  solutionAdded(_solutionAddress);
    }


 function isSolutionUnique(bytes32 key) public view returns (bool){
    	bool isUnique = true;
    	if (solutionsSubmitted[key].solutionsAddress != address(0)){
    		isUnique = false;
    	}
		return isUnique;	
    }
  // TODO Create a function to mint new NFT only after the solution has been verified
  //  - make sure the solution is unique (has not been used before)
  //  - make sure you handle metadata as well as tokenSuplly
  function mintNewNFT(address _to,uint256 tokenSuplly, uint[2] memory A, uint[2][2] memory B, uint[2] memory C, uint[2] memory input) public{
             		require(verifier.verifyTx(A,  B,  C,  input), "Incorrect solution"); 
                 	addSolution(_to, tokenSuplly, A,  B, C, input);            
              super.mint(_to,tokenSuplly);
  }
}







  







  


























