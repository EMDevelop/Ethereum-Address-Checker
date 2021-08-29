class FetchTransaction 

 def initialize (address)
  @origin_addresses = address
  @transaction_history = {}
 end

 attr_accessor :origin_addresses
 attr_reader :transaction_history

end


