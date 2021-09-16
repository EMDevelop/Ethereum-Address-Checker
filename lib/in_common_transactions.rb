class InCommonTransactions

  def initialize(transactions,addresses)
    @all_transactions = transactions
    @origin_addresses = addresses
    @transactions_in_common = Hash.new
  end

  attr_reader :transactions_in_common

  def analyse_addresses
    loop_all_transactions
    remove_transactions_with_one_address
    print_in_common_transactions
  end

  private 
  def loop_all_transactions
    @all_transactions.each { |origin_address, transaction_hash|
      loop_transaction_hashes(origin_address, transaction_hash)
    }
  end

  def loop_transaction_hashes(origin_address, hash_info)
    hash_info.each { |hash, trasaction_info|
      validate_transaction_address(origin_address, trasaction_info[:from])
      validate_transaction_address(origin_address,  trasaction_info[:to])
    }
  end

  def validate_transaction_address(origin_address, direction_address)
    if direction_address != origin_address
      log_addresses(origin_address, direction_address)      
    end
  end

  def log_addresses(origin_address, direction_address)
    @transactions_in_common[direction_address] ? @transactions_in_common[direction_address] << origin_address : @transactions_in_common[direction_address] = [origin_address]
  end

  def remove_transactions_with_one_address
    @transactions_in_common.each { |in_common_address, address_array| 
      if address_array.length < 2
        @transactions_in_common.delete(in_common_address)
      end
    }
  end

  def print_in_common_transactions
    @transactions_in_common.each { |in_common_address, address_array|  
      puts "Your Addresses #{address_array.join(', ')} have both made transactions (either to or from) #{in_common_address}"
    }
  end

end