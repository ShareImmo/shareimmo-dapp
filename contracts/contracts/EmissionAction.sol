// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

//ShareIssuanceContract anciennement
contract EmissionAction {
    // Mappage pour stocker le nombre d'actions détenu par chaque adresse
    mapping(address => uint256) public shares;

    // Mappage pour stocker les droits de vote des détenteurs d'actions
    mapping(address => bool) public votingRights;

    // Fonction pour émettre des actions aux détenteurs d'obligations lors de l'émission d'actions
    function issueShares(address bondHolder, uint256 numberOfShares) external {
        require(numberOfShares > 0, "Invalid number of shares");

         // Augmenter le nombre d'actions détenu par le détenteur d'obligation
        shares[bondHolder] += numberOfShares;
    }

    // Fonction pour accorder les droits de vote à un détenteur d'actions
    function grantVotingRights(address shareholder) external {
        require(shares[shareholder] > 0, "Not a shareholder");

        // Activer les droits de vote pour l'actionnaire
        votingRights[shareholder] = true;
    }

    // Fonction pour permettre à un actionnaire d'exercer ses droits de vote
    function exerciseVotingRights() external view {
        require(votingRights[msg.sender], "Voting rights not activated");

        // Logique pour exercer les droits de vote
        // ...
    }
}