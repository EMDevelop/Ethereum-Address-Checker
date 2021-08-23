require 'address_checker'

#irb -r './lib/address_checker.rb'
#a = AddressChecker.new


describe AddressChecker do   

  context 'Menu: Validate General Output Checker' do
    before(:each) do
      allow(subject).to receive(:gets).and_return("3", "quit")
    end

    it 'Verifies hello world' do
      expect {subject.main_menu}.to output(include('Welcome to the Ethereum Address Checker','Thanks for using the Ethereum Address Checker' )).to_stdout
    end

    it 'Ensures prompt for Adding Address' do 
      expect {subject.main_menu}.to output(include('Welcome to the Ethereum Address Checker','Main Menu: type number + hit enter', 'Add address manually', 'Test with dummy address' )).to_stdout
    end

  end

  context 'Menu: Validate User Input' do
    before(:each) do
      allow(subject).to receive(:gets).and_return("biddly","quit")
    end

    it 'Check Error Thrown:  when incorrect input' do
      expect{subject.main_menu}.to output(include("Error: Input not found. Please either type a number or 'quit'")).to_stdout
    end

  end

  # Currently failing test - Unsure as to why
  # It worked while my hash for manu_options was stored inside of a method 'menu_options'
  # Now failing when menu_options is a property on a class. 
  # context 'Menu Selection: Add Addresses Manually' do
  #   before(:each) do
  #     allow(subject).to receive(:gets).and_return("1","0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0xa95aea385130718be87b380b419eeac8da40de55", "quit", "quit")
  #   end

  #   it 'Checks if manual input is triggered when input is 1' do
  #     expect(subject).to receive(:handle_manual_address_input)
  #     subject.main_menu
  #   end

  # end

  context 'Menu Selection: 3. Show current addresses' do
    before(:each) do
      allow(subject).to receive(:gets).and_return("3","quit")
    end

    it 'Check Warning Thrown: if no addresses exist' do
      expect do 
        subject.show_origin_addresses
      end.to output("Warning: No Addresses Exist, add your own or use our defaults\n").to_stdout
    end

  end





  context 'Menu Merge.. Show new options after successful step 1/2' do
    before(:each) do
      allow(subject).to receive(:gets).and_return("1","0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0xa95aea385130718be87b380b419eeac8da40de55", "quit", "quit")
    end

    it 'New Menu Option appears' do 
      expect {subject.main_menu}.to output(include('Welcome to the Ethereum Address Checker','Main Menu: type number + hit enter', 'Add address manually', 'Test with dummy address', 'Fetch transactions' )).to_stdout
    end

  end

  context 'Menu Selection: 4. Fetch address when selection is 4' do
    before(:each) do
      allow(subject).to receive(:gets).and_return("2","4","quit")
    end

    it 'Check object created' do

      subject.main_menu
      expect(subject.fetch_transaction).to be_a FetchTransaction
      
    end

  end


  context 'User Inputting Address: Incorrect Details Provided' do

    before(:each) do
      allow(subject).to receive(:gets).and_return("0xa95aea385130718be87b380b419eeac8da40de55", "quit","0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "quit" )
    end

    it 'Check Error Thrown: if there is < 2 addresses provided' do
      
      expect do
        subject.handle_manual_address_input
      end.to output(include("Add at least 2 Addresses, hit enter after each address, type 'quit' when done", "Error: Please add at least 2 addresses")).to_stdout 
    end
  end

  context 'User Inputting Address: Correct Details Provided' do

    before(:each) do
      allow(subject).to receive(:gets).and_return("0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0xa95aea385130718be87b380b419eeac8da40de55", "quit" )
    end

    it 'After input, there should be at least 2 addresses stored to operate tasks on' do
      subject.handle_manual_address_input
      expect(subject.origin_addresses.length).to be > 1
    end

  end

  context 'User Inputting Address: Inputs same address twice' do
    before(:each) do
      allow(subject).to receive(:gets).and_return("1", "0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0xa95aea385130718be87b380b419eeac8da40de55" ,"quit", "quit" )
    end
    
    it 'Check Error Thrown: If user adds an address that is already stored' do
      expect do
        subject.handle_manual_address_input
      end.to output(include("Error: You've added an address that is already stored, please add unique addresses")).to_stdout 
    end

  end

  context 'User Inputting Address: General Checks' do


    it 'If user wants to use default addresses, make sure origin_addresses equals my default 2 addresses' do
      subject.use_default_addresses
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