// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// Contrat du Reverse Oracle
contract ReverseOracle {
    // Adresse de l'API bancaire
    address public bankAPI;

    // Événement déclenché lorsqu'une réponse est reçue de l'API bancaire
    event BankResponse(uint256 rentAmount);

    //ajouter par meriem
    // Array pour stocker les adresses des bénéficiaires de la répartition du loyer
    address[] private recipients;

    // Fonction pour configurer l'adresse de l'API bancaire
    function configureBankAPI(address _bankAPI) external {
        bankAPI = _bankAPI;
    }

    // Fonction pour récupérer le montant total du loyer à distribuer
    function getRentAmount() external returns (uint256) {
        // Appeler la fonction appropriée de l'API bancaire pour obtenir le montant du loyer
        // ...
        // Ici, vous devrez implémenter la logique de communication avec l'API bancaire

        // Supposons que vous avez reçu une réponse de l'API bancaire
        uint256 rentAmount = 1000; // Exemple de montant de loyer

        // Émettre l'événement de la réponse de l'API bancaire
        emit BankResponse(rentAmount);

        return rentAmount;
    }

    //ajouter par meriem - All below
    function isConfigured() external view returns (bool) {
        return bankAPI != address(0);
    }

    // Recuperer le nombre de beneficiaires pour la distribution du loyer
    function getRecipientCount() external view returns (uint256) {
        return recipients.length;
    }

    // Ajouter un nouveau beneficiaire pour la distribution du loyer
    function addRecipient(address recipient) external {
        require(recipient != address(0), "Adresse beneficiare non valide");
        recipients.push(recipient);
    }

    // Recuperer l'adresse du beneficiaire par index
    function getRecipient(uint256 index) external view returns (address) {
        require(index < recipients.length, "Invalid index");
        return recipients[index];
    }

    // Recuperer le montant total a distribuer entre les beneficiaires
    function getTotalDistributionAmount() external pure returns (uint256) {
        // Add your logic to calculate the total distribution amount here
        // For example, you can calculate the total based on some other data or condition.
        // For now, let's return a dummy value as an example.
        return 10000;
    }

}
