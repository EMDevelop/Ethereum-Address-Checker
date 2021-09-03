require './lib/formatting'
require 'rest-client'
require 'json'
require 'dotenv'


class FetchTransaction 

  include Formatting
  Dotenv.load

  def initialize (address)
   @origin_addresses = address
   @transaction_history = {}
  end
 
  attr_accessor :origin_addresses
  attr_reader :transaction_history
 
  def fetch_transactions
    print_begin_main_process("Fetching Transactions")
    for_each_address_do
    print_complete_main_process("COMPLETED: Fetch Transaction")
  end

  # private

  def etherscan_api(coin_type, address)
    url = generate_url(coin_type, address)
    response = convert_response_to_hash(send_request(url))
    handle_api_response(coin_type, address, response)
    store_transactions(address,coin_type,response["result"])
  end

  def store_transactions(address,coin_type,transactions)
    # print transactions

    transactions.each { |transaction| 
      @transaction_history[address][transaction["hash"]] = {:from => transaction["from"], :to=> transaction["to"], :coin => coin_type == :eth ? "Ethereum" : transaction["tokenName"] } 
    }
  end

  def handle_api_response(coin_type, address, response)
    raise "API Error: you may only send 5 calls per second" if response["status"] == "0" && response["message"] == "NOTOK"
    raise "API Error: Invalid Ethereum address" if response["status"] == "0" && response["message"] == "No transactions found"
    print_complete_sub_process("COMPLETED: Fetching")
  end

  def convert_response_to_hash(response)
    JSON.parse(response)
  end

  #The status field returns 0 for failed transactions and 1 for successful transactions
  def send_request(url)
    sleep(1)
    RestClient::Request.execute(:method => :get, :url => url, :timeout => 200, :open_timeout => 200)
  end

  def generate_url(coin_type, address)
    action = coin_type == :eth ? "txlist" : "tokentx"
    "http://api.etherscan.io/api?module=account&action=#{action}&address=#{address}&startblock=0&endblock=999999999&sort=asc&apikey=#{ENV["KEY"]}"
  end

  def create_keys(addresses)
    addresses.each { |address|
        if !@transaction_history[address] 
          @transaction_history[address] = {}
        end
    }
  end
    
  def for_each_address_do
    create_keys(@origin_addresses)
    @transaction_history.keys.each { |address| fetch_data(address) }
  end

  def fetch_data(address)
    print_begin_sub_process("Fetching Ethereum Transactions for #{address}")
    etherscan_api(:eth, address)
    print_begin_sub_process("Fetching ERC-20 Transactions for: #{address}")
    etherscan_api(:erc20, address)
  end

end