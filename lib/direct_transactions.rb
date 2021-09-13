class DirectTransactions

  def initialize(transactions,adresses)
    @all_transactions = transactions
    @origin_addresses = adresses
    @direct_transactions = {}
  end

  attr_reader :direct_transactions, :origin_addresses, :all_transactions

  def analyse_addresses
    loop_origin_addresses
    p "I ran"
    print_direct_transactions
    p "I also ran"
  end

  # private

  def print_direct_transactions
    @direct_transactions.each { |from, info|
      p "#{from} sent #{info[:coin]} to #{info[:to]}. For more info, transaction_hash: #{info[:hash]}"
    }
  end

  def loop_origin_addresses
    @origin_addresses.each { |origin_address|
      loop_all_transactions(origin_address.downcase)
    }
  end

  def loop_all_transactions(origin_address)
    @all_transactions.each { |transaction_address, transactions|
      if transaction_address.downcase != origin_address.downcase
        loop_transaction_hashes(transactions, origin_address, transaction_address)
      end 
    }
  end

  def loop_transaction_hashes(transactions, origin_address, transaction_address)
    transactions.each { | hash, transaction_info | 
      if origin_address.downcase == transaction_info[:from].downcase || origin_address.downcase == transaction_info[:to].downcase
        add_transaction(hash, transaction_info)
      end
    }
  end

  def add_transaction (hash, transaction_info)
    @direct_transactions[transaction_info[:from]] = {:to => transaction_info[:to], :coin => transaction_info[:coin], :hash=> hash}
  end

end

