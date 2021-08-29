require './lib/formatting'
class FetchTransaction 

  include Formatting

  def initialize (address)
   @origin_addresses = address
   @transaction_history = {}
  end
 
  attr_accessor :origin_addresses
  attr_reader :transaction_history
 
  def fetch_transactions
    print_begin_process("Fetching Transactions")
    print_complete_process("COMPLETED: Fetch Transaction")
  end
 
end