// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Importer le contrat BalanceRegistry
import "./BalanceRegistry.sol";

contract EmissionToken is ERC20 {
    address public admin;
    // Déclarer une variable de type BalanceRegistry
    BalanceRegistry private balanceRegistry;

    constructor(address _balanceRegistryAddress) ERC20("ShareImmo Token", "SIMMO") {
        admin = msg.sender;
        // Initialiser le registre des balances
        balanceRegistry = BalanceRegistry(_balanceRegistryAddress);
    }

    function mint(address to, uint256 amount) external {
        //require(msg.sender == admin, "seul l'administrateur peut emettre de nouveaux tokens");
        _mint(to, amount);

        // Mettre à jour la balance du destinataire dans le registre
        balanceRegistry.updateBalance(to, balanceOf(to));
    }

    function burn(address from, uint256 amount) external {
       // require(msg.sender == admin, "seul l'administrateur peut bruler des tokens");
        _burn(from, amount);

        // Mettre à jour la balance du compte de l'émetteur dans le registre
        balanceRegistry.updateBalance(from, balanceOf(from));
    }
}
