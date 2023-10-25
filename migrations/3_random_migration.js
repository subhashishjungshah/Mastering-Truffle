const random = artifacts.require("Random");

module.exports = function (deployer) {
  deployer.deploy(random);
};
