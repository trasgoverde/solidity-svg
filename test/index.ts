import { expect } from "chai";
import { ethers } from "hardhat";

describe("Greeter", () => {
  it("Should return the new greeting once it's changed", async () => {
    const contract = await (
      await ethers.getContractFactory("Greeter")
    ).deploy("Hello, world!");

    expect(await contract.greet()).to.equal("Hello, world!");

    await contract.setGreeting("Hola, mundo!");
    expect(await contract.greet()).to.equal("Hola, mundo!");
  });
});
