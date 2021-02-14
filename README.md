# CryptoStar

## Description

A simple ethereum blockchain based Smart contract/Front end app to buy and share stars.

## Specifications

- Truffle version -> **v5.1.65**
- OpenZeppelin version -> **v2.1.2**
- ERC721 Token Name -> **Sun Star Notary**
- ERC721 Token Symbol -> **SSN**
- Token Address ->

## Installation

- `npm install` (Root directory)
- `truffle compile` (Ensuring that GANACHE GUI is set up at PORT 7545)
- Necessary ENV variables to be injected is written over .env.example for copying it to .env (Valid only if willing to deploy over testnet)
- `truffle migrate --reset`
- `cd app && npm install`
- If you receive an error like

  ```bash
  scrypt@6.0.3 failed to install
  ```

  `npm install github:barrysteyn/node-scrypt#fb60a8d3c158fe115a624b5ffa7480f3a24b03fb `

  and then again `npm install`

- `npm run dev`
