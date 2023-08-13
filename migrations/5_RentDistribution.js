// 2_deploy_rent_distribution.js
const RentDistribution = artifacts.require("RentDistribution");
const ReverseOracle = artifacts.require("ReverseOracle");

module.exports = async function (deployer) {
  // Deploy the ReverseOracle contract first
  await deployer.deploy(ReverseOracle);
  const reverseOracleInstance = await ReverseOracle.deployed();

  // Deploy the RentDistribution contract and pass the address of the ReverseOracle contract as an argument to the constructor
  await deployer.deploy(RentDistribution, reverseOracleInstance.address);
};
