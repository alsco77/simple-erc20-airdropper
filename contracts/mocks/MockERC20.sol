//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.8;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
    constructor(string memory _name, string memory _symbol)
        public
        ERC20(_name, _symbol)
    {
        _mint(msg.sender, uint256(100000000).mul(10**18));
    }
}
