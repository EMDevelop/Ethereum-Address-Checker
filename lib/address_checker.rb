class AddressChecker

  def initialize
    @origin_addresses = []
  end

  attr_reader :origin_addresses

  def handle_manual_input 
      puts "Add at least 2 Addresses, hit enter after each address, type 'quit' when done"
      while true do
        address = gets.chomp
        break if address == "quit"
        check_ethereum_address_validity(address) ? @origin_addresses << address : (puts "Error: Invalid Ethereum Address")
      end
  end


  def input_origin_addresses_manually?(y_n)  

    if y_n == "y"
      handle_manual_input
    elsif y_n == "n"
      @origin_addresses = ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7","0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]
    else 
      print "Please only enter 'y' or 'n' into 'input_origin_addresses_manually'"
    end
      
  end

  def check_ethereum_address_validity(address)
    address.downcase!
    valid_address = true
    valid_address = false if address.length != 42 || address[0..1] != "0x"
    valid_address
  end

  def main_menu
    1
  end
  

end



address_investigation = AddressChecker.new



