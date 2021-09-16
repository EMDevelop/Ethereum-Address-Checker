#! /usr/bin/env ruby
########################################### 
###########################################
require 'rest-client'
require 'json'
require 'dotenv'

Dotenv.load
key = ENV["KEY"]    

address = ["0x72140C1886f8F2Dd932DCe06795901F8FB6378a7","0x0613Cd2076bd432C7A60a1b926b11B17BaAaFE11"]
# [
  # "0xa95aea385130718be87b380b419eeac8da40de55", 
  # "0x0dd80fcd70370650e79db794723e31848a593459", 
  # "0x4e7e1c73c116649c1c684acb6ec98bac4fbb4ef6", 
  # "0xc55ba66cab0298b3a67e1d0bf6a1613907941b09", 
  # "0xddee597e2404149c5e9aea899dfdf7c15874245e"
# ]

web = Hash.new

known_addresses = {
  "0x7be8076f4ea4a4ad08075c2508e481d6c946d12b" => "OpenSea Contract", 
  "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2" => "Wrapped Eth Contract", 
  "0x7a250d5630b4cf539739df2c5dacb4c659f2488d" => "Uniswap Privacy Router",
  "0xBd3531dA5CF5857e7CfAA92426877b022e612cf8" => "PudgyPenguins"
}

5.times {puts " "}


puts "---------------------------------FETCHING: Transactions For Address---------------------------------"
request_loop_count = 1
address.each { |target_address| 
  if !web[target_address] 
    web[target_address] = {"hash" => [], "from" => [], "to" => []}
  end
  url = "https://api.etherscan.io/api?module=account&action=txlist&address=#{target_address}&startblock=0&endblock=99999999&sort=asc&apikey=#{key}"
  response = RestClient::Request.execute(:method => :get, :url => url, :timeout => 200, :open_timeout => 200)
  jsonResponse = JSON.parse(response)
  p jsonResponse
  jsonResponse["result"].each { | transaction |
    web[target_address]["hash"].push(transaction["hash"])
    web[target_address]["from"].push(transaction["from"])
    web[target_address]["to"].push(transaction["to"])
  }
  puts " Address #{request_loop_count} -------------------"
  request_loop_count +=1
}
puts "---------------------------------COMPLETE: Data fully Fetched---------------------------------"

5.times {puts " "}

#

puts "---------------------------------CHECKING: Direct Transactions---------------------------------"

# Notes
# Loop through Array of addresses (a)
# Loop through the hash keys of the web {address => ... , address => ...}
# For Each Key that isn't "hash"
  # Looping through the array values of "to" and "from"          -- this no longer exists now
  # Check if the original address in the Array (a) exists in the transaction AS LONG AS the original address isn't looking at it's own transactions
  # Print which direction the transaction happend


# outer_counter = 0
# inner_count = 0
address.each { |outer_address|   # Looping through outer list of target addresses
  web.each { |inner_address, _|  # Looping through inner list of target addresses (the same addresses comparing with eachother)

    web[inner_address].each { |title_key, value| # Looping through the data options (hash, to, from) and the values

      if title_key != "hash" # Ignoring the hash, for this we're only interested in to and from addesses

        value.each { |array_address| # The hash values for each data option are stored as arrays, so we need to loop through them all
          if outer_address.downcase == array_address.downcase && outer_address.downcase != inner_address.downcase #is the target address present in any other target address's to/from data options?
            if title_key == "from"
              puts "Address '#{outer_address}' has has an outbound transaction to '#{inner_address}'"
            else title_key == "to"
              puts "Address '#{inner_address}' has has an outbound transaction to '#{outer_address}'"
            end
          end
        } 

      end

    }
    # inner_count +=1 
  }
  # outer_counter += 1
}
puts "---------------------------------COMPLETE: Direct Transactions ---------------------------------"

5.times {puts " "}

puts "---------------------------------CHECKING: Addresses In Common---------------------------------"

repeat_offenders = Hash.new

web.each { |target_address, title_key| 
  title_key.each { |title, address_arrays|
    if title != "hash"
      address_arrays.each { |array|
        if array != target_address
          if !repeat_offenders[array] 
            repeat_offenders[array] = [target_address] 
          else
            !repeat_offenders[array].include?(target_address) && repeat_offenders[array].push(target_address)
          end
        end
      }
    end
  }
}

red_herrings = known_addresses.transform_keys {|key| key.downcase}

repeat_offenders.each { |offender, target_address| 
  if red_herrings[offender.downcase] && target_address.length > 1
    puts "✕ ✕ ✕ #{red_herrings[offender]} | #{target_address.join(", ")}"
  elsif target_address.length > 1
    puts "#{offender} has transactions with #{target_address.length} target addresses: #{target_address.join(", ")}"
  end
}
puts "---------------------------------COMPLETE: Addresses In Common ---------------------------------"