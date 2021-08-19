class AddressChecker

  def initialize
    @origin_addresses = []
  end

  attr_reader :origin_addresses

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
      input_count = 0
      while true do
        address = input_address
        break if handle_address_input_outcome(input_count, address) == 'quit'
        input_count += 1
      end
  end

  def handle_address_input_outcome(count, input)
    if count >= 2 && input == "quit"
      return 'quit'
    elsif count < 2 && input == "quit"
      puts "Error: Please add at least 2 addresses"
    else
      check_address_validity(input) ? handle_address_storing(input) : (puts "Error: Invalid Ethereum Address")
    end
  end

  def handle_address_storing(input)
    @origin_addresses << input
  end

  def input_address
     gets.chomp
  end

  def check_address_validity(address)
    address.downcase!
    valid_address = true
    valid_address = false if address.length != 42 || address[0..1] != "0x"
    valid_address
  end

  def main_menu
    2
  end
  

end