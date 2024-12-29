// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol";
import "../contracts/ForestsDigitalVencane2024.sol";
import "../contracts/Constants.sol";

contract TestForestsDigitalVencane2024 {
    ForestsDigitalVencane2024 token;
    address deployer;

    function beforeAll() public {
        deployer = address(this); // Set the deployer address
        token = new ForestsDigitalVencane2024();
    }

    function testInitialSupply() public {
        uint256 totalSupply = token.totalSupply();
        Assert.equal(totalSupply, Constants.MAX_SUPPLY, "Initial supply should be equal to MAX_SUPPLY");
    }

    function testMintingToInvestor() public {
        uint256 investorBalance = token.balanceOf(Constants.INVESTOR);
        uint256 expectedBalance = Constants.MAX_SUPPLY - Constants.TOKENIZATION_REWARD;
        Assert.equal(investorBalance, expectedBalance, "Investor should receive MAX_SUPPLY - TOKENIZATION_FEE");
    }

    function testMintingToDeployer() public {
        uint256 deployerBalance = token.balanceOf(deployer);
        Assert.equal(deployerBalance, Constants.TOKENIZATION_REWARD, "Deployer should receive TOKENIZATION_FEE");
    }

    function testBurnFunction() public {
        uint256 burnAmount = Constants.TOKENIZATION_REWARD;
        token.transfer(address(this), burnAmount); // Transfer tokens to this contract for burning

        token.burn(burnAmount); // Burn tokens
        uint256 newTotalSupply = token.totalSupply();
        uint256 expectedSupply = Constants.MAX_SUPPLY - burnAmount;
        Assert.equal(newTotalSupply, expectedSupply, "Total supply should decrease by burn amount");
    }

    function testBurnMoreThanBalance() public {
        uint256 balanceBefore = token.balanceOf(address(this));
        uint256 burnAmount = balanceBefore + 1;

        try token.burn(burnAmount) {
            Assert.ok(false,"Burning more than the available balance should fail");          
        } catch (bytes memory) {
            Assert.ok(true,"Burning more than the available balance was not permitted");
        }
    }
}
