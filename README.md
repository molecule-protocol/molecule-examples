# molecule-core

[![Foundry][foundry-badge]][foundry]

[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg
[foundry]: https://getfoundry.sh/

![Tests](https://github.com/molecule-protocol/molecule-core/actions/workflows/test.yml/badge.svg?branch=main)

## Setup

This project was built using [Foundry](https://book.getfoundry.sh/). Refer to installation instructions [here](https://github.com/foundry-rs/foundry#installation).

```sh
git clone git@github.com:molecule-protocol/molecule-examples.git
cd molecule-examples
forge install
yarn build
forge test -vvvvv
```

Here are common use cases for Molecule Protocol:

### NFT Mint Allowlist (Whitelist)

Allow list (whitelist) is a common use case for NFT minting. By using Molecule Protocol in the NFT smart contract, the allow list can be added and managed easily. After the mint, the Molecule Protocol smart contract can be set to bypass entirely.

### On-Chain Compliance

AML: Most DeFi protocols enforce AML (Anti-Money-Laundering) at the UI level only. Molecule Protocol enables AML checks at the smart contract level, ensuring no unauthorized counterparties at any time.

KYC: Molecule Protocol is composable with KYC projects like [KYC Dao](https://kycdao.xyz/) and [Quadrata](https://quadrata.com/).

### Soulbound and Conditional-Soulbound Tokens

A soulbound token refers to an NFT token that cannot be transferred. For example, for KYC tokens, the identity token is tied to each wallet address, and transfer is prohibited.

Many Web3 loyalty programs or GameFi projects prevent transfer to avoid "farming." However, transfer should be conditionally allowed during redemption. Tokens should either be burned or transferred to the treasury.

Implementing these with Molecule Protocol is trivial and more flexible than hardcoding.

### [Subscription Payment](src/paywall/Subscription.sol)

Proof of payment can be implemented with adding an allowlist logic. By adding this payment check, proof of payment and even subscription payment can be verified before allowing smart contract executions. By decoupling the payment at the smart contract level, it enables subscriptions, installments, and many other payment options for DeFi projects.

## Contribution

Can you think of more use cases that Molecule Protocol can support? Please describe your idea, or demo your idea, or submit a PR (pull request) to us so we can share it with the entire community!

## Questions?

Send us questions on Twitter: [@moleculepro](https://twitter.com/moleculepro)

Or join our Discord: https://discord.gg/J8dqFK8ufA

