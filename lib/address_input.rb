require './lib/fetch_transaction.rb'
require './lib/formatting'

class AddressInput

  include Formatting

  def initialize
    @origin_addresses = []
    # @fetch_data = ""
    @menu_options = {
      "1"=>{description: "Add address manually", function: method(:handle_manual_address_input)},
      "2"=>{description: "Test with dummy address", function: method(:use_default_addresses)},
      "3"=>{description: "Show stored addresses", function: method(:show_origin_addresses)},
      "4"=>{description: "Delete stored addresses", function: method(:delete_addresses)},
    }
    @fetch_data_menu_options = {
      "5"=>{description: "Fetch transactions", function: method(:fetch_transactions)}
    }
    @fetch_transaction #Data will then be stored in checker.fetch_transaction.transaction_history
  end

  attr_reader :origin_addresses
  attr_reader :menu_options
  attr_reader :fetch_transaction

  def main_menu
    puts "Welcome to the Ethereum Address Checker"
    while true do
      display_menu_options
      break if handle_menu_input(user_input) == 'quit'
    end
  end

  def delete_addresses
     @origin_addresses = []
     puts green("Successfully deleted addresses")
  end

  def use_default_addresses
    @origin_addresses = ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7","0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]
    puts green("Using default Ethereum Addresses")
    merge_to_menu_options(@fetch_data_menu_options)
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

  def fetch_transactions
    if @origin_addresses.length < 2
      puts red("Error: No addresses defined, please either add addresses or use the defaults")
      return
    end
    @fetch_transaction = FetchTransaction.new(@origin_addresses)
    @fetch_transaction.fetch_transactions
  end

  private

  def display_menu_options 
    display_heading("Main Menu: type number + hit enter")
    @menu_options.each { |option_number, option_description| 
      puts "#{option_number}. #{option_description[:description]}"
    }
  end

  def handle_menu_input(input)
    if !is_menu_input_valid?(input)
      puts red("Error: Input not found. Please either type a number or 'quit'")
      return
    elsif input == 'quit'
      puts "Thanks for using the Ethereum Address Checker"
      return 'quit'
    else
      @menu_options[input][:function].call
    end
  end

  def is_menu_input_valid?(input)
    (@menu_options.key?(input) || input == 'quit') ? true : false
  end

  def handle_address_storing(input)
    @origin_addresses << input
    if @origin_addresses.length == 1 
      print green("Added ")
      puts red("you need 1 more address") 
    else
      puts green("Added, you now have #{@origin_addresses.length} addresses")
      puts yellow("Keep adding or type 'quit' to go back to Menu")
      merge_to_menu_options(@fetch_data_menu_options)
    end
  end

  def merge_to_menu_options(options)
    @menu_options.merge!(options)
  end

  def user_input
     gets.chomp
  end

end