// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// Importer le contrat BalanceRegistry
import "./BalanceRegistry.sol";

contract ReventeTokens {
    // Adresse du contrat BalanceRegistry
    BalanceRegistry public balanceRegistry;

    // Événement pour notifier les ventes de tokens
    event TokenSold(address indexed seller, address indexed buyer, uint256 amount, uint256 price);

    // Constructeur pour définir l'adresse du contrat BalanceRegistry
    constructor(address _balanceRegistryAddress) {
        balanceRegistry = BalanceRegistry(_balanceRegistryAddress);
    }

    // Fonction pour permettre à un détenteur de tokens de les vendre
    function sellTokens(uint256 amount, uint256 price) external {
        require(amount > 0, "Montant invalide");

        // Vérifier que le contrat BalanceRegistry est configuré
        require(address(balanceRegistry) != address(0), "L'adresse du contrat BalanceRegistry n'est pas definie");

        // Vérifier si le solde du vendeur est suffisant pour effectuer la vente
        require(balanceRegistry.getBalance(msg.sender) >= amount, "Solde insuffisant");

        // Mettre à jour le prix de vente du token
        balanceRegistry.setTokenOffer(msg.sender, price);

        // Effectuer le transfert des tokens vers le contrat BalanceRegistry
        balanceRegistry.transferTokens(msg.sender, address(this), amount);

        emit TokenSold(msg.sender, address(this), amount, price);
    }

    // Fonction pour permettre à un utilisateur d'acheter des tokens
    function buyTokens(address seller, uint256 amount) external payable {
        // Vérifier que le contrat BalanceRegistry est configuré
        require(address(balanceRegistry) != address(0), "L'adresse du contrat BalanceRegistry n'est pas definie");

        // Obtenir le prix de vente du token
        uint256 price = balanceRegistry.getTokenOffer(seller);
        require(price > 0, "Aucune offre de vente pour ce vendeur");
        require(msg.value >= price * amount, "Montant insuffisant pour acheter les tokens");

        // Effectuer le transfert des tokens de l'acheteur vers le vendeur via le contrat BalanceRegistry
        balanceRegistry.transferTokens(msg.sender, seller, amount);

        // Effectuer le paiement au vendeur en utilisant la valeur envoyée par l'acheteur
        payable(seller).transfer(msg.value);

        emit TokenSold(seller, msg.sender, amount, price);
    }
}
