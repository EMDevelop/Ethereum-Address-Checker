require './lib/formatting'
require 'rest-client'
require 'json'
require 'dotenv'

class FetchTransaction 

  include Formatting

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

  def etherscan_api(coin_type)
    url = get_url(coin_type)
    response = convert_response_to_hash(send_request(url))
    response["message"]
  end

  private

  def convert_response_to_hash(response)
    JSON.parse(response)
  end

  def send_request(url)
    RestClient::Request.execute(:method => :get, :url => url, :timeout => 200, :open_timeout => 200)
  end

  def get_url(coin_type)
    action = coin_type == :eth ? "txlist" : "tokentx"
    "http://api.etherscan.io/api?module=account&action=#{action}&address=0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11&startblock=0&endblock=999999999&sort=asc&apikey=FCT8FVAED7SPWI634Z1653CSAF38RFGBFB"
  end

  def create_keys(addresses)
    addresses.each { |address|
        if !@transaction_history[address] 
          @transaction_history[address] = {"hash" => [], "from" => [], "to" => [], "coin" =>[]}
        end
    }
  end
    
  def for_each_address_do
    create_keys(@origin_addresses)
    fetch_data
  end

  def fetch_data
    print_begin_sub_process("Fetching Ethereum Transactions")
    etherscan_api(:eth)
    print_complete_sub_process("COMPLETED: Fetching ERC-20 Transactions")
    print_begin_sub_process("Fetching ERC-20 Transactions")
    etherscan_api(:eth)
    print_complete_sub_process("COMPLETED: Fetching ERC-20 Transactions")
  end


 
end