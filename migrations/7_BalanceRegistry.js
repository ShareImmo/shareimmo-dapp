const BalanceRegistry = artifacts.require("BalanceRegistry");

module.exports = function (deployer) {
  deployer.deploy(BalanceRegistry);
};
