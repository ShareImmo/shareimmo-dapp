// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// Importation du contrat du Reverse Oracle
import "./ReverseOracle.sol";

contract RentDistribution {
    // Adresse du contrat du Reverse Oracle
    ReverseOracle public reverseOracle;

    // Mapping pour stocker les montants de loyer à distribuer pour chaque adresse
    mapping(address => uint256) public rentDistributionAmounts;

    // Événement déclenché lorsqu'un virement bancaire est effectué
    event BankTransfer(address indexed recipient, uint256 amount);

    // Constructeur - Initialise le contrat du Reverse Oracle
    constructor(address _reverseOracleAddress) {
        reverseOracle = ReverseOracle(_reverseOracleAddress);
    }

    // Fonction pour définir le montant de loyer à distribuer pour une adresse donnée
    function setRentDistribution(address recipient, uint256 amount) external {
        require(amount > 0, "Montant de loyer invalide");

        rentDistributionAmounts[recipient] = amount;
    }

    // Fonction pour effectuer la répartition du loyer
    function distributeRent() external {
        // Vérifier que le contrat du Reverse Oracle a été configuré
        require(reverseOracle.isConfigured(), "Reverse Oracle non configure");

        // Obtenir le montant total du loyer à distribuer
        uint256 totalRentAmount = reverseOracle.getRentAmount();

        // Parcourir les adresses de répartition et effectuer les virements bancaires
        for (uint256 i = 0; i < reverseOracle.getRecipientCount(); i++) {
            address recipient = reverseOracle.getRecipient(i);
            uint256 rentAmount = (rentDistributionAmounts[recipient] * totalRentAmount) / reverseOracle.getTotalDistributionAmount();

            // Effectuer le virement bancaire vers l'adresse du bénéficiaire
            // ...
            // Ici, vous pouvez intégrer la logique pour effectuer le virement bancaire en utilisant une API bancaire

            // Émettre l'événement du virement bancaire effectué
            emit BankTransfer(recipient, rentAmount);
        }
    }
}
