# simple-erc20-airdropper

No paywall - simply airdrop ERC20 tokens to an array of addresses

Requires 2 arrays of inputs:
```
_recipients (address[]) - e.g. ["0x293...f234", "0x293...f234", "0x293...f234"]
_amounts (uint256[]) - e.g. [1000000000000000000, 250000000000000000000, 250000000000000000000, 250000000000000000000]
```
Amounts must be in base units - if token has 18 decimals, the number for 1 token is 1e18 base units.

**Steps:**

1. Move only the amount you wish to airdrop to a 'hot wallet' for executing the transaction
1. Approve spending by calling `approve(<airdropper>, <totalAmount>)` on the **token contract** via Etherscan
1. Call `checkAirdropValidity` on airdrop contract
1. Call `airdropToken` on airdrop contract
