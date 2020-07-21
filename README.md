# simple-erc20-airdropper

No paywall - simply airdrop ERC20 tokens to an array of addresses

Deployed address: [0xda13e3afed9c112bd906c732684a49dd65b178fd](https://etherscan.io/address/0xda13e3afed9c112bd906c732684a49dd65b178fd#code)

Requires 2 arrays of inputs:
```
_recipients (address[]) - e.g. ["0x293...f234", "0x293...f234", "0x293...f234"]
_amounts (uint256[]) - e.g. [1000000000000000000, 250000000000000000000, 250000000000000000000, 250000000000000000000]
```
Amounts must be in base units - if token has 18 decimals, the number for 1 token is 1e18 base units.

**Steps:**

1. Move only the amount you wish to airdrop to a 'hot wallet' for executing the transaction
1. Approve spending by calling `approve(0xda13e3afed9c112bd906c732684a49dd65b178fd, <totalAmount>)` on the **airdrop token contract** via Etherscan
1. Call `checkAirdropValidity` on [Etherscan](https://etherscan.io/address/0xda13e3afed9c112bd906c732684a49dd65b178fd#readContract)
1. Call `airdropToken` on [Etherscan](https://etherscan.io/address/0xda13e3afed9c112bd906c732684a49dd65b178fd#writeContract)
