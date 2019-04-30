// migrating the appropriate contracts
//var Verifier = artifacts.require("./Verifier.sol");
//var SolnSquareVerifier = artifacts.require("./SolnSquareVerifier.sol");
let Ownable = artifacts.require("./Ownable.sol");

module.exports = function(deployer) {
  //deployer.deploy(Verifier).then(()=>{
    
//deployer.deploy(Verifier);
//deployer.deploy(SolnSquareVerifier);
deployer.deploy(Ownable);
  //return deployer.deploy(SolnSquareVerifier, Verifier.address);
//});
};
