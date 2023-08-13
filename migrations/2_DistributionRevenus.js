const DistributionRevenus = artifacts.require("./DistributionRevenus.sol");

module.exports = function (deployer) {
  const addresses = ["0xce22cDCBBc7284de228F80c2af48E582075c647C","0x2c83C3a29FE33707b8C4429120e4463AB439F91f"];
  const balances = [100,100];
  deployer.deploy(DistributionRevenus, addresses, balances);
};