require 'fetch_transaction'

describe FetchTransaction do

  let(:fetch) { FetchTransaction.new(["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"])  }
  let(:address) { ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"] }
  let(:transactions) { {"0x72140C1886f8F2Dd932DCe06795901F8FB6378a7"=>{}, "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"=>{}} }


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
    let(:api_fail_wrong_address) { '{"status":"0", "message":"No transactions found"}' }
    let(:api_success) { '{"status":"1"}' }
    
    before do
      allow(fetch).to receive(:store_transactions).and_return('ok')
    end

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
    end

    #https://info.etherscan.com/api-return-errors/
    it 'Checks for an invalid response' do
      allow(fetch).to receive(:send_request).and_return(api_fail_max_limit)
      expect { fetch.fetch_transactions }.to raise_error "API Error: you may only send 5 calls per second"
    end

    it 'Checks if a valid ethereum address was used in the request' do
      allow(fetch).to receive(:send_request).and_return(api_fail_wrong_address)
      expect { fetch.fetch_transactions }.to raise_error "API Error: Invalid Ethereum address"
    end

    #As it will crash if it is not fine I can use include, otherwise i couldn't
    it 'Informs user of a successful API call' do
      allow(fetch).to receive(:send_request).and_return(api_success)
      expect { fetch.fetch_transactions }.to output(include("✓ COMPLETED: Fetching")).to_stdout
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

  context 'Storing Data' do
  
    let(:eth_transactions) { [{"blockNumber"=>"11980496", "timeStamp"=>"1614975897", "hash"=>"0xa61aafe3f30fb54d9fac4536850fdf5a9bfb6ed3345a770bacabc48614b4bea6", "nonce"=>"28", "blockHash"=>"0x07f13027766a5d6024ca864fb590822133a5c1a4ddedb025134dbc3a0e1ff8c4", "transactionIndex"=>"136", "from"=>"0x72140c1886f8f2dd932dce06795901f8fb6378a7", "to"=>"0x0613cd2076bd432c7a60a1b926b11b17baaafe11", "value"=>"233517170249926628", "gas"=>"21000", "gasPrice"=>"116000000000", "isError"=>"0", "txreceipt_status"=>"1", "input"=>"0x", "contractAddress"=>"", "cumulativeGasUsed"=>"9723463", "gasUsed"=>"21000", "confirmations"=>"1168087"}] }
    let(:erc20_transactions) { [{"blockNumber"=>"11938688", "timeStamp"=>"1614420203", "hash"=>"0xe45d3d41819e4747c03a0a9bd2b6dd0628062db2d6a92f0c0c086ad7e185791b", "nonce"=>"19", "blockHash"=>"0xa625e5cbfdde9c5d6e72103cd29e8e847dac9a7af8e58309ff9da567c1ceaae9", "from"=>"0x72140c1886f8f2dd932dce06795901f8fb6378a7", "contractAddress"=>"0xd2dda223b2617cb616c1580db421e4cfae6a8a85", "to"=>"0x0613cd2076bd432c7a60a1b926b11b17baaafe11", "value"=>"0", "tokenName"=>"Bondly Token", "tokenSymbol"=>"BONDLY", "tokenDecimal"=>"18", "transactionIndex"=>"174", "gas"=>"41775", "gasPrice"=>"102000000000", "gasUsed"=>"27850", "cumulativeGasUsed"=>"11051244", "input"=>"deprecated", "confirmations"=>"1209946"}]}
    let(:eth_stored) { {"0x72140C1886f8F2Dd932DCe06795901F8FB6378a7"=>{"0xa61aafe3f30fb54d9fac4536850fdf5a9bfb6ed3345a770bacabc48614b4bea6" => {:from => "0x72140c1886f8f2dd932dce06795901f8fb6378a7", :to => "0x0613cd2076bd432c7a60a1b926b11b17baaafe11", :coin => "Ethereum"} }, "0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"=>{}} }
    let(:empty) { "" } 

    it 'Stores Ethereum Chain transactions' do
      allow(fetch).to receive(:send_request).and_return('ok')
      allow(fetch).to receive(:convert_response_to_hash).and_return('ok')
      allow(fetch).to receive(:store_transactions).with("0x72140C1886f8F2Dd932DCe06795901F8FB6378a7", :eth, eth_transactions)
      allow(fetch).to receive(:store_transactions)
      allow(fetch).to receive(:store_transactions)
      allow(fetch).to receive(:store_transactions)
      fetch.fetch_transactions
      expect(fetch.transaction_history).to eq eth_stored
    end
  end

end
