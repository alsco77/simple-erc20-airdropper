import { expect } from "chai";
import { Signer, BigNumber } from "ethers";

declare var ethers;

describe("SimpleAirdropper", () => {
  context("performing an airdrop", () => {
    let accounts: Signer[];
    let addresses: string[] = [];
    let airdropper;
    let mockToken;

    beforeEach(async function() {
      accounts = await ethers.getSigners();
      for (const account of accounts) {
        addresses.push(await account.getAddress());
      }
      const SimpleAirdropper = await ethers.getContractFactory(
        "SimpleAirdropper"
      );
      airdropper = await SimpleAirdropper.deploy();
      const MockERC20 = await ethers.getContractFactory("MockERC20");
      mockToken = await MockERC20.deploy("MOCK1", "MK1");
    });

    it("should fail with insufficient balance");
    it("should fail with insufficient allowance");
    // console.log(ethers.Wallet);
    // var newAddr = ethers.Wallet.createRandom();
    // console.log("Address: " + newAddr.getAddress());
    it("should fail with too many addresses");
    it("should fail with mismatched arrays");

    it("should distribute the specified tokens correctly", async () => {
      const sender = addresses[0];
      const recipients = addresses.slice(1, 11);

      const amounts = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
      const expectedAmount = amounts.reduce((p, c) => p + c, 0);
      const senderBalBefore = await mockToken.balanceOf(sender);
      const recipientBalsBefore = await Promise.all(
        recipients.map((r) => mockToken.balanceOf(r))
      );

      await mockToken.approve(airdropper.address, expectedAmount);

      const [isValid, reason, total] = await airdropper.checkAirdropValidity(
        mockToken.address,
        recipients,
        amounts
      );
      expect(isValid).to.equal(true);
      expect(reason).to.equal("Ready to drop");
      expect(total.toNumber()).to.equal(expectedAmount);

      await airdropper.airdropToken(mockToken.address, recipients, amounts);

      const senderBalAfter = await mockToken.balanceOf(sender);
      expect(senderBalAfter.toString()).to.equal(
        senderBalBefore.sub(BigNumber.from(expectedAmount).toString())
      );
      const recipientBalsAfter = await Promise.all(
        recipients.map((r) => mockToken.balanceOf(r))
      );
      recipientBalsAfter.map((r, i) =>
        expect(r.toString()).to.equal(
          recipientBalsBefore[i].add(BigNumber.from(amounts[i]).toString())
        )
      );
    });
  });
});
