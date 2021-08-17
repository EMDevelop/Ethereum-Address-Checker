class AddressChecker

  def initialize
    @origin_addresses = []
  end

  attr_reader :origin_addresses

  def input_origin_addresses_manually?(y_n)  
    # If input is  
    
    if y_n != "y" && y_n != "n"
      print "Please only enter 'y' or 'n' into 'input_origin_addresses_manually'"
    end

    if y_n == "y"
      puts "You've chosen to add your own addresses, please add them 1 by 1"
      puts "When you've added the first address, press enter"
      while true do
        puts "Add An Ethereum Wallet Address"
        address = gets.chomp
        if check_ethereum_address_validity(address) 
          @origin_addresses << address
          puts "Would you like to add another Address ? y/n"
          input_more_y_n = gets.chomp
          if input_more_y_n == "n"
            break
          end
        else
          puts "You have entered an invalid ethereum address, try again"
        end
      end
    else y_n == "n"
      @origin_addresses = ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7","0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]
    end
      
  end

  def check_ethereum_address_validity(address)
    address.downcase!
    valid_address = true
    valid_address = false if address.length != 42
    valid_address = false if address[0..1] != "0x"
    valid_address
  end
  
end

address_investigation = AddressChecker.new

address_investigation.input_origin_addresses_manually?("h")

print address_investigation.origin_addresses
