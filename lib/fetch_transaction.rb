class FetchTransaction 

 def initialize(addresses)
  @origin_addresses = addresses
 end

 attr_reader :origin_addresses

end