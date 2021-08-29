require 'fetch_transaction'

describe FetchTransaction do

  let(:fetch) { FetchTransaction.new(["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]) }


  context 'Checking initial setup of the Fetch Transaction class' do

    it 'Checks that the address checker can store multiple addresses' do
      expect(fetch.origin_addresses).to eq ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]
    end

    it 'Checks an empty object exists to store transaction history' do
      expect(fetch.transaction_history).to be_instance_of(Hash)
    end

  end


  context 'Fetching Transactions' do

    it 'Checks that the fetch transaction method exists' do
      expect(fetch).to respond_to(:fetch_transactions)
    end

    it 'Checks the user is informed that the transactions are being fetched' do
      expect {fetch.fetch_transactions}.to output(include('Fetching Transactions')).to_stdout
    end


  end

  context 'Checking console output letting user know that processes are happening' do
    
    it 'Checks Begin message appears' do
      expect(fetch).to respond_to(:print_begin_process).with(1).argument
    end

    it 'Checks Complete message appears' do
      expect(fetch).to respond_to(:print_complete_process).with(1).argument
    end


  end

end