require 'address_checker'

describe AddressChecker do   

  context 'Check Input Data.' do

    it 'Check input Address is an Array' do
      addressChecker = AddressChecker.new
      expect(subject.origin_addresses).to be_kind_of(Array)
    end

    it 'Check if there are more than 1 input address' do
      addressChecker = AddressChecker.new
      expect(subject.origin_addresses.length).to be > 1
    end

  end 

end