//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.8;

import "@nomiclabs/buidler/console.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";

// console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);

contract SimpleAirdropper {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    uint256 private constant limit = 200;

    event Multisended(uint256 total, address tokenAddress);

    function checkAirdropValidity(
        IERC20 _token,
        address[] _recipients,
        uint256[] _amounts
    )
        external
        view
        returns (
            bool isValid,
            string reason,
            uint256 totalAmount
        )
    {
        // TODO
        return (true, "", 0);
    }

    function airdropToken(
        IERC20 _token,
        address[] _recipients,
        uint256[] _amounts
    ) external {
        uint256 total = 0;
        require(_contributors.length <= arrayLimit());
        ERC20 erc20token = ERC20(token);
        uint8 i = 0;
        for (i; i < _contributors.length; i++) {
            erc20token.transferFrom(msg.sender, _contributors[i], _balances[i]);
            total += _balances[i];
        }
        setTxCount(msg.sender, txCount(msg.sender).add(1));
        emit Multisended(total, token);
    }
}
