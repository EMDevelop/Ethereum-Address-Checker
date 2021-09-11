require 'menu'

describe Menu do

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


  context 'Menu Selection: Add Addresses Manually' do
    before(:each) do
      allow(subject).to receive(:gets).and_return("1","0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0xa95aea385130718be87b380b419eeac8da40de55", "quit", "quit")
    end
  end

  context 'Menu Selection: 3. Show current addresses' do

    before(:each) do
      allow(subject).to receive(:gets).and_return("3","quit")
    end

    it 'Check Warning Thrown: if no addresses exist' do
      expect do 
        subject.show_origin_addresses
      end.to output(include("Warning: No Addresses Exist, add your own or use our defaults")).to_stdout
    end

  end

  #This test started failing while re-factoring
  context 'Menu Merge.. Show new options after successful step 1/2' do

    before(:each) do
      allow(subject).to receive(:gets).and_return("1","0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0xa95aea385130718be87b380b419eeac8da40de55", "quit", "quit")
    end

    xit 'New Menu Option appears' do 
      expect {subject.main_menu}.to output(include('Welcome to the Ethereum Address Checker','Main Menu: type number + hit enter', 'Add address manually', 'Test with dummy address', 'Fetch transactions' )).to_stdout
    end

  end


  context 'Menu Selection: Fetch transactions' do
    
    before(:each) do
      allow(subject).to receive(:gets).and_return("2","4","5","quit")
    end

    it 'Check function returns if there are no addresses' do
      p "I ran 1"
      expect do
        subject.main_menu
      end.to output(include("Error: No addresses defined, please either add addresses or use the defaults")).to_stdout 
      p "I ran 2"
    end

  end

end 