require 'fetch_transaction'

describe FetchTransaction do

  let(:fetch) { FetchTransaction.new([]) }

  context 'Checking initial setup of the Fetch Transaction class' do

    it 'Checks that the address checker can store multiple addresses' do
      fetch.origin_addresses = ["addressA", "addressB"]
      expect(fetch.origin_addresses).to eq ["addressA", "addressB"]
    end

    it 'Checks an empty object exists to store transaction history' do
      expect(fetch.transaction_history).to be_instance_of(Hash)
    end

  end


end