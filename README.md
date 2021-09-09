# Ethereum Wallet Address Checker

This project can be used to check whether 2 or more Ethereum wallets have made transactions between eachother, or have any addresses in common that they've sent/received ERC-20 Tokens or Ethereum to/from.

## How To Use

#### Through the Command Line

- Clone the project `git clone https://github.com/EMDevelop/cryptoAddressWeb.git`
- Navigate into your new directory `cd cryptoaddressWeb`
- Open IRB `irb -r './lib/address_checker.rb'`
- Create a new address checker in irb `checker = AddressChecker.new`
- Begin the main menu in irb `checker.main_menu`
- Follow menu instructions, and also:
  - Please use at least 2 Ethereum addresses
  - Please make sure they are valid Ethereum addresses
  - If you want to exit the application at any point then type `quit` until you see `Thanks for using the Ethereum Address Checker`

#### Required To Run

- You'll need to install a version of Ruby
- Build with Mac OSX, not sure if this would work on Windows.
- .env - There is only 1 environment variable, simple setup, you need to:
  - Visit https://etherscan.io/
  - Create account / sign in
  - Navigate to https://etherscan.io/myapikey
  - Add a new API key
  - Create a `.env` file in the root of this directory
  - Inside the .env, create a key/value pair `KEY=YOUR_KEY_HERE`

## Extra Notes

- Only works with Ethereum addresses
- I have limited transactions allowed per minute on my free version
- Please use, copy, fork, message me for questions, anything goes.
