pragma solidity ^0.5.0;

// TODO define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
import "./Verifier.sol";
import "./ERC721Mintable.sol";

// TODO define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is ERC721Mintable{

	Verifier verifier;

	//constructor
	constructor(address _verifierContract) ERC721Mintable() public{
        verifier = Verifier(_verifierContract);
    }

	// TODO define a solutions struct that can hold an index & an address
	struct Solution {
    	uint256 id;
		address solutionAddress;
	}

	// TODO define an array of the above struct
	Solution[] solutions;

	// TODO define a mapping to store unique solutions submitted
	mapping(bytes32 => Solution) private solutionsSubmitted;

	// TODO Create an event to emit when a solution is added
	event solutionAdded(address solutionAddress);

	// TODO Create a function to add the solutions to the array and emit the event
	function addSolution(address _solutionAddress, uint256 _id, uint[2] memory A, uint[2] memory A_p, uint[2][2] memory B, uint[2] memory B_p, uint[2] memory C, uint[2] memory C_p, uint[2] memory H, uint[2] memory K, uint[2] memory input) public {
		bytes32 key = keccak256(abi.encodePacked(A, A_p, B, B_p, C, C_p, H, K, input));
		require(isSolutionUnique(key), "Solution already exsits.");
        Solution memory sol = Solution({id: _id, solutionAddress: _solutionAddress});
        solutionsSubmitted[key] = sol;
        solutions.push(sol);
        emit solutionAdded(_solutionAddress);
    }

    function isSolutionUnique(bytes32 key) public view returns (bool){
    	bool isUnique = true;
    	if (solutionsSubmitted[key].solutionAddress != address(0)){
    		isUnique = false;
    	}
		return isUnique;	
    }

    // TODO Create a function to mint new NFT only after the solution has been verified
	//  - make sure the solution is unique (has not been used before)
	//  - make sure you handle metadata as well as tokenSuplly
	function mintNewNFT(address _to, uint256 _tokenId, uint[2] memory A, uint[2] memory A_p, uint[2][2] memory B, uint[2] memory B_p, uint[2] memory C, uint[2] memory C_p, uint[2] memory H, uint[2] memory K, uint[2] memory input) public{
		require(verifier.verifyTx(A, A_p, B, B_p, C, C_p, H, K, input), "Incorrect solution");
		addSolution(_to, _tokenId, A, A_p, B, B_p, C, C_p, H, K, input);
		super.mint(_to, _tokenId);
	}

}

  


























