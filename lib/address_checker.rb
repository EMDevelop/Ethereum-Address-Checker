class AddressChecker

  def initialize
    @origin_addresses = []
  end

  attr_reader :origin_addresses


  #General 
  def user_input
     gets.chomp
  end

  def display_heading(text)
    puts text
    dash_length = text.length
    (1..dash_length).each {|dash| print dash == dash_length ? "-\n" : "-"}

  end

  #Add address
  def input_origin_addresses_manually(y_n)  
    if y_n == "y"
      handle_manual__address_input
    elsif y_n == "n"
      @origin_addresses = ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7","0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]
    else 
      print "Please only enter 'y' or 'n' into 'input_origin_addresses_manually'"
    end
  end

  def handle_manual__address_input 
      puts "Add at least 2 Addresses, hit enter after each address, type 'quit' when done"
      while true do
        address = user_input
        break if handle_address_input_outcome( address) == 'quit'
      end
  end

  def handle_address_input_outcome(input)
    if @origin_addresses.length >= 2 && input == "quit"
      return 'quit'
    elsif @origin_addresses.length < 2 && input == "quit"
      puts "Error: Please add at least 2 addresses"
    else
      check_address_validity(input) ? handle_address_storing(input) : (puts "Error: Invalid Ethereum Address")
    end
  end

  def handle_address_storing(input)
    @origin_addresses << input
  end

  def check_address_validity(address)
    address.downcase!
    valid_address = true
    valid_address = false if address.length != 42 || address[0..1] != "0x"
    valid_address
  end

  #Menu
  def main_menu
    puts "Welcome to the Ethereum Address Checker"
    while true do
      display_menu_options
      menu_input = user_input
      break if handle_menu_input(menu_input) == 'quit'
    end
  end

  def display_menu_options 
    display_heading("Main Menu: type number + hit enter")
    menu_options.each { |option_number, option_description| 
      puts "#{option_number}. #{option_description}"
    }
  end

  def menu_options
    {
      "1"=>"Add address manually",
      "2"=>"Test with dummy address"
    }
  end

  def handle_menu_input(input)
    if input == 'quit'
      puts "Thanks for using the Ethereum Address Checker"
      return 'quit'
    end
  end
  
end