#! /usr/bin/env ruby
########################################### 
###########################################
require 'rest-client'
require 'json'
require 'dotenv'

Dotenv.load
key = ENV["KEY"]    #Can be found at https://etherscan.io/myapikey, free

# List of target addresses
address = 
[
  "0xa95aea385130718be87b380b419eeac8da40de55", 
  "0x0dd80fcd70370650e79db794723e31848a593459", 
  "0x4e7e1c73c116649c1c684acb6ec98bac4fbb4ef6", 
  "0xc55ba66cab0298b3a67e1d0bf6a1613907941b09", 
  "0xddee597e2404149c5e9aea899dfdf7c15874245e"
]
web = Hash.new

# For each Target Address
address.each { |target_address| 
  # Create a key within the web for each target address
  if !web[target_address] 
    web[target_address] = {"timeStamp" => [], "from" => [], "to" => []}
  end
  # Send a request to etherscan for that address (ensure you get an API Key from )
  url = "https://api.etherscan.io/api?module=account&action=txlist&address=#{target_address}&startblock=0&endblock=99999999&sort=asc&apikey=#{key}"
  response = RestClient::Request.execute(:method => :get, :url => url, :timeout => 200, :open_timeout => 200)
  jsonResponse = JSON.parse(response) 

  puts jsonResponse

  # Fetch relevant data, data Available Includes:
  # blockNumber, timeStamp, hash, nonce, blockHash, transactionIndex
  # from, to, value, gas, gasPrice, isError, txreceipt_status, input
  # contractAddress, cumulativeGasUsed, gasUsed, confirmations
  jsonResponse["result"].each { | transaction |
    web[target_address]["timeStamp"].push(transaction["to"])
    web[target_address]["from"].push(transaction["to"])
    web[target_address]["to"].push(transaction["to"])
  }
}

puts web
# # Loop through keys of web 
# web.each { |key, _| 
#   puts key
# }

 




