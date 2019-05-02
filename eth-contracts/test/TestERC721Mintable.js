var ERC721Mintable = artifacts.require('ERC721Mintable');

contract('ERC721Mintable', accounts => {

    const account_one = accounts[0];
    const account_two = accounts[1];

    describe('match erc721 spec', function () {
        beforeEach(async function () { 
            this.contract = await ERC721Mintable.new({from: account_one});

            // TODO: mint multiple tokens
            await this.contract.mint(account_one, 1);
             await this.contract.mint(account_one, 2);
            await this.contract.mint(account_one, 3);
             await this.contract.mint(account_one, 4);
             
        })

        it('should return total supply', async function () {
            let result = await this.contract.totalSupply();
            assert.equal(result, 4, "Incorrect number of minted tokens.");
            
        })

        it('should get token balance', async function () { 
            let resultOfBalance = await this.contract.balanceOf(account_one);
            assert.equal(resultOfBalance, 4, "Incorrect number of account_one token balance.");
            let resultOfBalance2 = await this.contract.balanceOf(account_two);
            assert.equal(resultOfBalance2, 0, "Incorrect number of account_two token balance.");
            
        })

        // token uri should be complete i.e: https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1
        it('should return token uri', async function () { 
            let resultTokenUri = await this.contract.tokenURI(1);
            assert.equal(resultTokenUri, "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1", "TokenUri is not found.")   
        })

        it('should transfer token from one owner to another', async function () {
            let result = await this.contract.transferFrom(account_one, account_two, 2);
            let owner = await this.contract.ownerOf(2);
            assert.equal(owner, account_two, "Owner was not changed.");
        })
    });

    describe('have ownership properties', function () {
        beforeEach(async function () { 
            this.contract = await ERC721Mintable.new({from: account_one});
        })

        it('should fail when minting when address is not contract owner', async function () {
            let reverted = false;
            try{
               let resultMint4 = await this.contract.mint(account_one, 4, "baseURI4", {from: account_two}); 
            } catch (e) {
                reverted = true;
            }
            assert.equal(reverted, true, "It allows to mint not an owner.");
            
        })

        it('should return contract owner', async function () {
            let result = await this.contract.isOwner({from: account_one}); 
            assert.equal(result, true, "It does not return the owner.");
        })

    });
})
