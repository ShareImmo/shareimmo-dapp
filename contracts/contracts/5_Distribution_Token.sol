// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DistributionRevenus {
    // Mapping pour stocker les soldes de tokens des détenteurs
    mapping(address => uint256) public balances;
    
    // Tableau pour stocker les adresses des détenteurs de tokens
    address[] public tokenHolders;
    
    // Total des tokens en circulation
    uint256 public totalSupply;

    // Événement pour notifier les paiements effectués
    event Payment(address indexed recipient, uint256 amount);

    // Constructeur pour initialiser les soldes des détenteurs de tokens
    constructor(address[] memory _addresses, uint256[] memory _balances) payable {
        require(_addresses.length == _balances.length, "Longueurs de donnees invalides");

        for (uint256 i = 0; i < _addresses.length; i++) {
            balances[_addresses[i]] = _balances[i];
            tokenHolders.push(_addresses[i]);
            totalSupply += _balances[i];
        }
    }

    // Fonction pour distribuer les revenus aux détenteurs de tokens
    function distribute(uint256 distributedAmount) external payable {
        for (uint256 i = 0; i < tokenHolders.length; i++) {
            address recipient = tokenHolders[i];
            uint256 paymentAmount = calculatePayment(recipient,distributedAmount);

            require(paymentAmount > 0, "Pas de paiement du jour pour le destinataire");

            // Effectuer le paiement au destinataire
            // (Supposons l'existence d'une fonction de paiement externe)
            makePayment(payable(recipient), paymentAmount);
            emit Payment(payable(recipient), paymentAmount);
        }
    }


    // Fonction pour calculer le montant du paiement pour un destinataire donné
    function calculatePayment(address recipient,uint256 amount) internal view returns (uint256) {
        // Calculer le montant du paiement en fonction du solde de tokens du destinataire
        uint256 tokenBalance = balances[recipient];
      //  uint256 totalBalance = address(this).balance;
         uint256 paymentAmount = (tokenBalance * amount) / totalSupply;
        return paymentAmount;
    }

    // Fonction pour effectuer le paiement au destinataire
    function makePayment(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Fonds insuffisants pour effectuer le paiement");
        recipient.transfer(amount);
    }

}
