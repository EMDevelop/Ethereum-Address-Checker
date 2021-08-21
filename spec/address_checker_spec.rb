require 'address_checker'

#irb -r './lib/address_checker.rb'
#a = AddressChecker.new


describe AddressChecker do   


  context 'Menu Checker' do
    before(:each) do
      allow(subject).to receive(:gets).and_return("1", "quit")
    end

    it 'verifies hello world' do
      expect {subject.main_menu}.to output(include('Welcome to the Ethereum Address Checker','Thanks for using the Ethereum Address Checker' )).to_stdout
    end

    it 'Ensures prompt for Adding Address' do 
      expect {subject.main_menu}.to output(include('Welcome to the Ethereum Address Checker','Main Menu: type number + hit enter', 'Add address manually', 'Test with dummy address' )).to_stdout
    end

  end

  context 'User Inputting Address: Incorrect Details Provided' do

    before(:each) do
      allow(subject).to receive(:gets).and_return("0xa95aea385130718be87b380b419eeac8da40de55", "quit","0xa95aea385130718be87b380b419eeac8da40de55", "quit" )
    end

    it 'Throws error if there is < 2 addresses provided' do
      
      expect do
        subject.handle_manual__address_input
      end.to output(include("Add at least 2 Addresses, hit enter after each address, type 'quit' when done", "Error: Please add at least 2 addresses")).to_stdout 
      output().to_stdout 
    end
  end

  context 'User Inputting Address: Correct Details Provided' do

    before(:each) do
      allow(subject).to receive(:gets).and_return("0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "quit" )
    end

    it 'After input, there should be at least 2 addresses stored to operate tasks on' do
      subject.input_origin_addresses_manually("y")
      expect(subject.origin_addresses.length).to be > 1
    end


  end

  context 'User Inputting Address: General Checks' do
 
    it 'if input is not y or n for manual address input, print error' do      
      expect do
        subject.input_origin_addresses_manually("h")
      end.to output("Please only enter 'y' or 'n' into 'input_origin_addresses_manually'").to_stdout 
    end

    it 'If user wants to use default addresses, make sure origin_addresses equals my default 2 addresses' do
      subject.input_origin_addresses_manually("n")
      expect(subject.origin_addresses).to eq ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7","0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11" ]
    end


    it 'checks if the input address is correct length' do
      expect(subject.check_address_validity("0x72140C1886f8F2D06795901FB6378a7")).to eq false
    end

    it 'checks if the input address written in Hex (starts with) with 0x' do
      expect(subject.check_address_validity("px72140C1886f8F2Dd932DCe06795901FB6378a7")).to eq false
    end

    it 'checks if a valid address will address will be accepted' do
      expect(subject.check_address_validity("0xa95aea385130718be87b380b419eeac8da40de55")).to eq true
    end

  end 


end