// 2_deploy_share_immo_token.js
const EmissionToken = artifacts.require("EmissionToken");

module.exports = function (deployer) {
    const address = "0xce22cDCBBc7284de228F80c2af48E582075c647C";
  deployer.deploy(EmissionToken, address);
};
