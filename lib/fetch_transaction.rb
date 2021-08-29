class FetchTransaction 

  def initialize (address)
   @origin_addresses = address
   @transaction_history = {}
  end
 
  attr_accessor :origin_addresses
  attr_reader :transaction_history
 
  def fetch_transactions
    
  end
 
  def print_begin_process(message)
    
  end

  def print_complete_process(message)

  end

end


