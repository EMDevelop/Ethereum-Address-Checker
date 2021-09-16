require 'in_common_transactions'
describe InCommonTransactions do

  context 'Check on addresses that are in common' do

    let(:addresses) { ["address_a","address_b"] } 
    let(:final) {{"address_z" => ["address_a","address_b"] }}
    let(:all_transactions) { {"address_a"=>{"hashA"=>{:from=>"address_a", :to=>"address_b", :coin=>"Ethereum"}, "hashB"=>{:from=>"address_c", :to=>"address_a", :coin=>"Bondly"}, "hashf"=>{:from=>"address_z", :to=>"address_a", :coin=>"Rarible"}}, "address_b"=>{"HashA"=>{:from=>"address_a", :to=>"address_b", :coin=>"Ethereum"}, "hashC"=>{:from=>"address_b", :to=>"address_d", :coin=>"Zeus"}, "hashf"=>{:from=>"address_b", :to=>"address_z", :coin=>"USD Tether"}}, "address_e"=>{"hashA"=>{:from=>"address_e", :to=>"address_f", :coin=>"Ethereum"}, "hashC"=>{:from=>"address_x", :to=>"address_e", :coin=>"Zeus"}}} }
    let(:in_common) { InCommonTransactions.new(all_transactions,addresses)}

    it 'checks transactions are stored corrrectly after running' do
      in_common.analyse_addresses
      expect(in_common.transactions_in_common).to eq final
    end

  end

end