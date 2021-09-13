require 'direct_transactions'
describe DirectTransactions do

  context 'converts data into new hash' do
    
    let(:addresses) { ["address_a","address_b"] }
    let(:direct_transaction) { {"address_a"=>{:to=>"address_b", :coin=>"Ethereum", :hash=>"hashA"}} }
    let(:all_transactions) { {"address_a"=>{"hashA"=>{:from=>"address_a",:to=>"address_b",:coin=>"Ethereum"},"hashB"=>{:from=>"address_c",:to=>"address_a",:coin=>"Bondly"}},"address_b"=>{"HashA"=>{:from=>"address_a",:to=>"address_b",:coin=>"Ethereum"},"hashC"=>{:from=>"address_b",:to=>"address_d",:coin=>"Zeus"}},"address_e"=>{"hashA"=>{:from=>"address_e",:to=>"address_f",:coin=>"Ethereum"},"hashC"=>{:from=>"address_x",:to=>"address_e",:coin=>"Zeus"}}} }

    let(:direct) { DirectTransactions.new(all_transactions,addresses)}

    it 'new hash with direct transactions' do
      direct.analyse_addresses
      expect(direct.direct_transactions).to eq direct_transaction
    end

    it 'prints the hash out' do
      expect {direct.analyse_addresses}.to output(include("address_a sent Ethereum to address_b. For more info, transaction_hash: hashA")).to_stdout
    end
    
  end

end