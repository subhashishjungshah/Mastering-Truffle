const etherPrice = artifacts.require("EtherPrice");

module.exports = function (deployer) {
  deployer.deploy(etherPrice);
};
