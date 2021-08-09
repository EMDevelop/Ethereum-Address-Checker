#! /usr/bin/env ruby
########################################### 
###########################################

require 'rest-client'
require 'json'
require 'dotenv'

Dotenv.load

address = "0xa95aea385130718be87b380b419eeac8da40de55"
# [
#   "0xa95aea385130718be87b380b419eeac8da40de55", 
#   "0x0dd80fcd70370650e79db794723e31848a593459", 
#   "0x4e7e1c73c116649c1c684acb6ec98bac4fbb4ef6", 
#   "0xc55ba66cab0298b3a67e1d0bf6a1613907941b09", 
#   "0xddee597e2404149c5e9aea899dfdf7c15874245e"
# ]
key = ENV["KEY"]
url = "https://api.etherscan.io/api?module=account&action=txlist&address=#{address}&startblock=0&endblock=99999999&sort=asc&apikey=#{key}"
web = Hash.new

 
# address.map { |target_address| 
  
# }

response = RestClient.get url
jsonResponse = JSON.parse(response)

jsonResponse["result"].each { | transaction |
  puts transaction["from"]
  puts transaction["to"]
}
