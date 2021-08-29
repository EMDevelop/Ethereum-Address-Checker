require 'fetch_transaction'

describe FetchTransaction do

  let(:fetch) { FetchTransaction.new(["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]) }
  let(:address) { ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"] }
  let(:transactions) { {"0x72140C1886f8F2Dd932DCe06795901F8FB6378a7"=>{"hash"=>[], "from"=>[], "to"=>[], "coin"=>[]}, "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"=>{"hash"=>[], "from"=>[], "to"=>[], "coin"=>[]}}}

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


    it 'Checks the user is informed that the transactions are complete' do
      expect {fetch.fetch_transactions}.to output(include('COMPLETED: Fetch Transaction')).to_stdout
    end

    it 'Checks that loop transactions has access to the transaction_array' do
      expect(fetch).to respond_to(:transaction_loop)
    end

    it 'Checks that a hash key is created by looping through transactions' do
      fetch.transaction_loop
      expect(fetch.transaction_history).to eq transactions
    end


    context 'Fetch Ethereum Chain Transactions' do

     
    end

    # context 'Fetch ERC-20 Transactions' do

    # end


  end

  context 'Checking console output letting user know that processes are happening' do
    
    it 'Checks Begin message appears' do
      expect(fetch).to respond_to(:print_begin_main_process).with(1).argument
    end

    it 'Checks Complete message appears' do
      expect(fetch).to respond_to(:print_complete_main_process).with(1).argument
    end

  end

end