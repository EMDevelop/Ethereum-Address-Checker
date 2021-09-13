require './lib/fetch_transaction.rb'
require './lib/formatting'

class AddressInput

  include Formatting

  def initialize
    @origin_addresses = []
  end

  attr_reader :origin_addresses

  def delete_addresses
    @origin_addresses = []
    puts green("Successfully deleted addresses")
  end

  def use_default_addresses
    @origin_addresses = ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7","0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]
    puts green("Using default Ethereum Addresses")
  end

  def handle_manual_address_input 
      puts white("Add at least 2 Addresses, hit enter after each address, type 'quit' when done")
      while true do
        address = user_input
        break if handle_address_input_outcome(address) == 'quit'
      end
  end

  def show_origin_addresses
    if @origin_addresses.length == 0
      puts yellow("Warning: No Addresses Exist, add your own or use our defaults")
    else
      puts green("Addresses Stored")
      @origin_addresses.each {|address| puts white(address)}
    end
  end

  def handle_address_input_outcome(input)
    if @origin_addresses.length >= 2 && input == "quit"
      return 'quit'
    elsif @origin_addresses.length < 2 && input == "quit"
      puts red("Error: Please add at least 2 addresses")
    elsif @origin_addresses.include?(input.downcase)
      puts red("Error: You've added an address that is already stored, please add unique addresses")
    else
      check_address_validity(input) ? handle_address_storing(input) : (puts red("Error: Invalid Ethereum Address"))
    end
  end

  def check_address_validity(address)
    address.downcase!
    valid_address = true
    valid_address = false if address.length != 42 || address[0..1] != "0x"
    valid_address
  end

  private

  def handle_address_storing(input)
    @origin_addresses << input.downcase
    if @origin_addresses.length == 1 
      print green("Added ")
      puts red("you need 1 more address") 
    else
      puts green("Added, you now have #{@origin_addresses.length} addresses")
      puts yellow("Keep adding or type 'quit' to go back to Menu")
    end
  end

  def user_input
    gets.chomp
  end

end