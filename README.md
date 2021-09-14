# Ethereum Wallet Address Checker

This project can be used to check whether 2 or more Ethereum wallets have made transactions between eachother, or have any addresses in common that they've sent/received ERC-20 Tokens or Ethereum to/from.

## What should you expect?

You can input 2 or more Ethereum addresses into this application and it will:

- Fetch high level transaction data from Etherscan.io (to, from, hash, date and so on)
- Determines whether any of your addresses you entered have made any transactions to or from eachother (and outputs to the screen)
- Determines whether any of your addresses you entered have made any transactions with any addresses in common
  - e.g. address A and address B have both made transactions to address C
  - Contract addresses should show up as the owner of that contract, and not an Ethereum address (this is WIP, looking for an API to do this for me)

---

## How To Use

#### Through the Command Line

- Clone the project `git clone https://github.com/EMDevelop/cryptoAddressWeb.git`
- Navigate into your new directory `cd cryptoaddressWeb`
- Run `bundle install` (you may need in `gem install bundle`)
- Open IRB `irb -r './lib/menu.rb'`
- Create a new address checker in irb `checker = Menu.new`
- Begin the main menu in irb `menu.main_menu`
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

---

## My Approach

I began coding this application entirely within `API.rb`. If you look inside of that file you can see how messy, unstructured and incomplete the code was. Since I've been on Makers Academy, I decided to re-factor this code to be written:

- With TDD from the start
- Separation of concerns (test files separate from the coding files)
- Encapsulation of similar functionality into classes
- Logical Naming including multiple helper functions and descriptive parameters
- RESTful API testing (of HTTP response codes)
- I've also added New functionality
  - A main menu
  - A basic Ethereum address validator (char length & starting with 0x)
  - Allow demo with two default addresses

Half way through this project, I realised I had a Menu object which was both handling the main menu, and also handling the address input and validation. I separated this class out into a `Menu` and `AddressInput` classes, along with separating their tests into separate files (and making them all pass again, which was harder than I thought it would be!).

I will hook this up to a front end very soon. Thanks for checking out the project, I hope it's useful!
