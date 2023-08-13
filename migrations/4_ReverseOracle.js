// 2_deploy_reverse_oracle.js
const ReverseOracle = artifacts.require("ReverseOracle");

module.exports = function (deployer) {
  deployer.deploy(ReverseOracle);
};
