const DyFactory = artifacts.require("DyFactory");


module.exports = function(deployer) {
    // Use deployer to state migration tasks.
    deployer.deploy(DyFactory);
};
