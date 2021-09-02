require 'fetch_transaction'

describe FetchTransaction do

  let(:fetch) { FetchTransaction.new(["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]) }
  let(:address) { ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"] }
  let(:transactions) { {"0x72140C1886f8F2Dd932DCe06795901F8FB6378a7"=>{"hash"=>[], "from"=>[], "to"=>[], "coin"=>[]}, "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"=>{"hash"=>[], "from"=>[], "to"=>[], "coin"=>[]}}}
  let(:json_string) { {
  "status": "1",
  "message": "OK",
  "result": [
    {
      "key1": "value1"
    },
    {
      "key2": "value2"
    }
  ]
}}

  context 'Checking initial setup of the Fetch Transaction class' do

    it 'Checks that the address checker can store multiple addresses' do
      expect(fetch.origin_addresses).to eq ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]
    end

    it 'Checks an empty object exists to store transaction history' do
      expect(fetch.transaction_history).to be_instance_of(Hash)
    end

  end


  context 'Fetching Transactions' do

    let(:api_fail_max_limit) { '{"status":"0", "message":"NOTOK"}' }

    it 'Checks the user is informed that the transactions are being fetched' do
      allow(fetch).to receive(:send_request).and_return('ok')
      allow(fetch).to receive(:convert_response_to_hash).and_return('ok')
      expect {fetch.fetch_transactions}.to output(include('Fetching Transactions')).to_stdout
    end

    it 'Checks that a hash key is created by looping through transactions' do
      allow(fetch).to receive(:send_request).and_return('ok')
      allow(fetch).to receive(:convert_response_to_hash).and_return('ok')
      fetch.fetch_transactions
      expect(fetch.transaction_history).to eq transactions
      pp fetch.transaction_history 
    end

    #https://info.etherscan.com/api-return-errors/
    it 'Checks for an invalid response' do
      allow(fetch).to receive(:send_request).and_return(api_fail_max_limit)
      expect { fetch.fetch_transactions }.to raise_error "API Error: you may only send 5 calls per second"
    end
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