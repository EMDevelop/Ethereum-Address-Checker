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
    print_begin_main_process("Fetching Transactions")
    transaction_loop
    print_complete_main_process("COMPLETED: Fetch Transaction")
  end

  def transaction_loop
    create_keys(@origin_addresses)
  end

  private

  def create_keys(addresses)
    addresses.each { |address|
        if !@transaction_history[address] 
          @transaction_history[address] = {"hash" => [], "from" => [], "to" => [], "coin" =>[]}
        end
    }
  end
 
end