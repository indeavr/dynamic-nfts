const DyFactory = artifacts.require("DyFactory");

contract("DyFactory", async accounts => {
    it("should be able to mind", async () => {
        const Contract = await DyFactory.deployed();
        await Contract.mint.call("test");
        const sup = await Contract.totalSupply.call();

        assert.equal(sup.valueOf(), 1);
    });

    it("should be able to set correct metadataURI", async () => {
        const Contract = await DyFactory.deployed();
        const expected = "test";

        await Contract.mint.call(expected);
        const tokenURI = await Contract.tokenURI.call();

        assert.equal(tokenURI.valueOf(), expected);
    });

    it("should be able to mint to correct address", async () => {
        const Contract = await DyFactory.deployed();

        await Contract.mintTo.call("test", "0x0000000000000000000000000000000000000001");
        
        const bal = await Contract.balanceOf.call("0x0000000000000000000000000000000000000001");

        assert.equal(bal.valueOf(), 1);
    });

    it("should be able to mint and own", async () => {
        const Contract = await DyFactory.deployed();

        await Contract.mintTo.call("test");
        const bal = await Contract.balanceOf.call(accounts[0]);

        assert.equal(bal.valueOf(), 1);
    });

    it("should be able to call canMint", async () => {
        const Contract = await DyFactory.deployed();

        const canMint = await Contract.canMint.call();

        assert.equal(canMint.valueOf(), false);
    });
});
