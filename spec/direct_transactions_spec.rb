require 'direct_transactions'
describe DirectTransactions do

  context 'converts data into new hash' do
    
    let(:direct_transaction) { {"hashA"=>{:from=>"address_a", :to=>"address_b", :coin=>"Ethereum"}} }
    let(:all_transactions) { {"address_a"=>{"hashA"=>{:from=>"address_a",:to=>"address_b",:coin=>"Ethereum"},"hashB"=>{:from=>"address_c",:to=>"address_a",:coin=>"Bondly"}},"address_b"=>{"HashA"=>{:from=>"address_a",:to=>"address_b",:coin=>"Ethereum"},"hashC"=>{:from=>"address_b",:to=>"address_d",:coin=>"Zeus"}},"address_e"=>{"HashA"=>{:from=>"address_e",:to=>"address_f",:coin=>"Ethereum"},"hashC"=>{:from=>"address_x",:to=>"address_e",:coin=>"Zeus"}}} }


    it 'new hash with direct transactions' do
      subject.analyse_addresses
      expect(subject.direct_transactions).to eq direct_transaction
    end

  end

end