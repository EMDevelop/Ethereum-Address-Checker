describe InCommonTransactions do

  context 'Check on addresses that are in common' do

    let(:addresses) { ["address_a","address_b"] }
    let(:direct) { DirectTransactions.new(all_transactions,addresses)}

    it 'checks transactions are stored corrrectly after running' do
      
    end

  end

end