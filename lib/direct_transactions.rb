class DirectTransactions

  def initialize(transactions,adresses)
    @all_transactions = transactions
    @origin_addresses = adresses
    @direct_transactions = {}
  end

  attr_reader :direct_transactions

  def analyse_addresses
    loop_origin_addresses
    @direct_transactions
  end

  private

  def loop_origin_addresses
    @origin_addresses.each { |origin_address|
      loop_all_transactions(origin_address)
    }
  end

  def loop_all_transactions(origin_address)
    @all_transactions.each { |transaction_address, transactions|
      if transaction_address != origin_address
        loop_transaction_hashes(transactions, origin_address, transaction_address)
      end 
    }
  end

  def loop_transaction_hashes(transactions, origin_address, transaction_address)
    # puts "Comparing #{origin_address} with #{transaction_address} you get \n transactions: #{transactions}"
    transactions.each { | hash, transaction_info | 
      if origin_address == transaction_info[:from] || origin_address == transaction_info[:to]
        add_transaction(hash, transaction_info)
      end
    }
  end

  def add_transaction (hash, transaction_info)
    @direct_transactions[transaction_info[:from]] = {:to => transaction_info[:to], :coin => transaction_info[:coin], :hash=> hash}
  end

end

