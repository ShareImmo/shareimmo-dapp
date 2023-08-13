const EmissionAction = artifacts.require("EmissionAction");

module.exports = function (deployer) {
  deployer.deploy(EmissionAction);
};
