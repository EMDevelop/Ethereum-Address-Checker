require './lib/fetch_transaction.rb'
require './lib/direct_transactions.rb'
require './lib/address_input.rb'
require './lib/formatting'

class Menu

  include Formatting

  def initialize
    @menu_options = {
      "1"=>{description: "Add address manually", function: method(:handle_manual_address_input)},
      "2"=>{description: "Test with dummy address", function: method(:use_default_addresses)},
      "3"=>{description: "Show stored addresses", function: method(:show_origin_addresses)},
      "4"=>{description: "Delete stored addresses", function: method(:delete_addresses)},
    }
    @fetch_data_menu_options = {
      "5"=>{description: "Fetch transactions", function: method(:fetch_transactions)}
    }
    @add_address = AddressInput.new
    @fetch_transaction
  end

   attr_reader :menu_options
   attr_reader :fetch_transaction

  def main_menu
    puts "Welcome to the Ethereum Address Checker"
    while true do
      display_menu_options
      break if handle_menu_input(user_input) == 'quit'
    end
  end

  def handle_manual_address_input 
    @add_address.handle_manual_address_input
    merge_to_menu_options(@fetch_data_menu_options)
  end

  def use_default_addresses 
    @add_address ||= AddressInput.new
    @add_address.use_default_addresses
    merge_to_menu_options(@fetch_data_menu_options)
  end

  def delete_addresses
    @add_address.delete_addresses
  end

  def fetch_transactions
    if @add_address.origin_addresses.length < 2
      puts red("Error: No addresses defined, please either add addresses or use the defaults")
      return
    end
    @fetch_transaction = FetchTransaction.new(@add_address.origin_addresses)
    @fetch_transaction.fetch_transactions
  end


  def show_origin_addresses
    @add_address.show_origin_addresses
  end

  private

  def merge_to_menu_options(options)
    @menu_options.merge!(options)
  end

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

  def user_input
     gets.chomp
  end

end