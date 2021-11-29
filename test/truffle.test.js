const DyFactory = artifacts.require("DyFactory");

contract("DyFactory", async accounts => {
    it("should be able to mind", async () => {
        const Contract = await DyFactory.deployed();
        await Contract.mint("test");
        const sup = await Contract.totalSupply();

        assert.equal(sup.toString(), "2");
    });

    it("should be able to set correct metadataURI", async () => {
        const Contract = await DyFactory.deployed();
        const expected = "test";

        await Contract.mintTo(expected, accounts[0]);

        const tokenURI = await Contract.tokenURI.call(0);

        assert.equal(tokenURI.toString(), expected);
    });

    it("should be able to mint to correct address", async () => {
        const Contract = await DyFactory.deployed();

        await Contract.mintTo("test", "0x0000000000000000000000000000000000000001");
        const bal = await Contract.balanceOf.call("0x0000000000000000000000000000000000000001");

        assert.equal(bal.toString(), "1");
    });

    it("should be able to mint and own", async () => {
        const Contract = await DyFactory.deployed();

        await Contract.mintTo("test", accounts[0]);

        const bal = await Contract.balanceOf.call(accounts[0]);

        assert.equal(bal.toString(), "3");
    });

    it("should be able to canMint", async () => {
        const Contract = await DyFactory.deployed();

        const canMint = await Contract.canMint.call(accounts[0]);

        assert.equal(canMint, true);
    });
});
