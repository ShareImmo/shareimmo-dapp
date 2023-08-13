// 2_deploy_contrat_revente_tokens.js
const ReventeTokens = artifacts.require("ReventeTokens");

module.exports = function (deployer) {
    const address = "0xce22cDCBBc7284de228F80c2af48E582075c647C";
  deployer.deploy(ReventeTokens, address);
};
