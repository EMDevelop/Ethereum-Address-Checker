require 'address_checker'

describe AddressChecker do   

  subject = AddressChecker.new

  context 'Main Menu' do
    it 'checks main menu exists' do
      expect(subject.main_menu).to eq 1
    end
  end

  context 'Check Input Data.' do

  
    it 'if input is not y or n for manual address input, print error' do
      expect do
        subject.input_origin_addresses_manually?("h")
      end.to output("Please only enter 'y' or 'n' into 'input_origin_addresses_manually'").to_stdout 
    end

    it 'If user wants to use default addresses, make sure origin_addresses equals my default 2 addresses' do
      subject.input_origin_addresses_manually?("n")
      expect(subject.origin_addresses).to eq ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7","0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11" ]
    end

    it 'If user wants to add their own addresses, check that they add more than 1 address' do
      subject.input_origin_addresses_manually?("y")
      # allow_any_instance_of(Object).to receive(:gets).and_return('0xa95aea385130718be87b380b419eeac8da40de55', '0xa95aea385130718be87b380b419eeac8da40de55', 'quit')
      # expect(subject).to receive(:puts).with("Add at least 2 Addresses, hit enter after each address, type 'quit' when done")
      # allow(subject).to receive(:gets).and_return('0xa95aea385130718be87b380b419eeac8da40de55', '0xa95aea385130718be87b380b419eeac8da40de55', 'quit')
      # subject.stub(gets: 'user input')
      # expect(STDOUT).to receive(:puts).with("Add at least 2 Addresses, hit enter after each address, type 'quit' when done")
      # allow(STDIN).to receive(:gets).and_return('0xa95aea385130718be87b380b419eeac8da40de55', '0xa95aea385130718be87b380b419eeac8da40de55', 'quit')
      # expect($stdout).to receive(:puts).with("Add at least 2 Addresses, hit enter after each address, type 'quit' when done")
      # allow($stdin).to receive(:gets).and_return('0xa95aea385130718be87b380b419eeac8da40de55', '0xa95aea385130718be87b380b419eeac8da40de55', 'quit')
      expect(subject.origin_addresses.length).to be > 1
    end

    it 'checks if the input address is correct length' do
      expect(subject.check_ethereum_address_validity("0x72140C1886f8F2D06795901FB6378a7")).to eq false
    end

    it 'checks if the input address written in Hex (starts with) with 0x' do
      expect(subject.check_ethereum_address_validity("px72140C1886f8F2Dd932DCe06795901FB6378a7")).to eq false
    end

    it 'checks if a valid address will address will be accepted' do
      expect(subject.check_ethereum_address_validity("0xa95aea385130718be87b380b419eeac8da40de55")).to eq true
    end

  end 


end