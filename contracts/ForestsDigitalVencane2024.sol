// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Constants.sol";

contract ForestsDigitalVencane2024 is ERC20 {
    constructor() ERC20("Forests.Digital Vencane 2024", "fdVNC24") {
        // Attribute investors
        _mint(
            Constants.INVESTOR,
            Constants.MAX_SUPPLY - Constants.TOKENIZATION_REWARD
        );
        // Attribute tokenization fees
        _mint(msg.sender, Constants.TOKENIZATION_REWARD);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}
