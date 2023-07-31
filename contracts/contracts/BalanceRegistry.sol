// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BalanceRegistry {
    // Mapping pour stocker les soldes des détenteurs de tokens
    mapping(address => uint256) private balances;

    // Mapping pour stocker les offres de vente des détenteurs de tokens
    mapping(address => uint256) private tokenOffers;

    // Fonction pour transférer des tokens entre des adresses
    function transferTokens(address from, address to, uint256 amount) external {
        require(balances[from] >= amount, "Solde insuffisant pour le transfert");
        balances[from] -= amount;
        balances[to] += amount;
    }

    // Fonction pour définir l'offre de vente d'un token
    function setTokenOffer(address seller, uint256 price) external {
        tokenOffers[seller] = price;
    }

    // Fonction pour récupérer le solde d'un détenteur de tokens
    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }

    // Fonction pour récupérer l'offre de vente d'un token
    function getTokenOffer(address account) external view returns (uint256) {
        return tokenOffers[account];
    }

     // Fonction pour mettre à jour la balance d'un détenteur de tokens
    function updateBalance(address account, uint256 balance) external {
        balances[account] = balance;
    }
}
