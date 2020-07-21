//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.8;

import "@nomiclabs/buidler/console.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";

contract SimpleAirdropper {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    uint256 private constant RECIPIENT_LIMIT = 200;

    event Airdropped(uint256 total, IERC20 token, address sender);

    /**
     * @notice Call this function before attempting to 'airdropToken' to
     * check that you have balance and have inputted the data correctly
     * @param _token ERC20 Token to airdrop
     * @param _recipients Array of recipients to drop to
     * @param _amounts Base units to send to each recipient
     * @return isValid - true or false
     * @return reason - Why this validity?
     * @return totalAmount - total units of dropped token
     */
    function checkAirdropValidity(
        IERC20 _token,
        address[] calldata _recipients,
        uint256[] calldata _amounts
    )
        external
        view
        returns (
            bool isValid,
            string memory reason,
            uint256 totalAmount
        )
    {
        uint8 len = uint8(_recipients.length);
        if (len != _amounts.length) return (false, "Mistmatching arrays", 0);
        if (len > RECIPIENT_LIMIT) return (false, "Maximum 200 recipients", 0);

        uint256 total = 0;
        for (uint8 i = 0; i < len; i++) {
            total = total.add(_amounts[i]);
        }

        uint256 allowance = _token.allowance(msg.sender, address(this));
        if (total > allowance)
            return (
                false,
                "Insufficient allowance - you must first approve this contract to spend the token",
                total
            );

        uint256 balance = _token.balanceOf(msg.sender);
        if (total > balance)
            return (
                false,
                "Insufficient balance - you do not have enough token to spend",
                total
            );

        return (true, "Ready to drop", total);
    }

    /**
     * @notice Airdrops the token to the specified recipients
     * @param _token ERC20 Token to airdrop
     * @param _recipients Array of recipients to drop to
     * @param _amounts Base units to send to each recipient
     */
    function airdropToken(
        IERC20 _token,
        address[] calldata _recipients,
        uint256[] calldata _amounts
    ) external {
        uint8 len = uint8(_recipients.length);
        require(len == _amounts.length, "Mismatching arrays");
        require(len <= RECIPIENT_LIMIT, "Too many recipients");

        uint256 totalSupply = _token.totalSupply();
        require(totalSupply > 0, "Invalid token");

        uint256 total = 0;
        for (uint8 i = 0; i < len; i++) {
            uint256 amount = _amounts[i];
            address recipient = _recipients[i];

            _token.transferFrom(msg.sender, recipient, amount);
            total = total.add(amount);

            console.log("Airdropping '%s' to '%s'", amount, recipient);
        }

        emit Airdropped(total, _token, msg.sender);
    }
}
