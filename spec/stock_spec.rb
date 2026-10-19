require_relative '../lib/stock'

RSpec.describe Stock do
  describe '#initialize' do
    it 'should initialize with a all values' do
      stock = Stock.new('AAPL','Apple Inc', 344.62, 2.0 )
      expect(stock.symbol).to eq('AAPL')
      expect(stock.name).to eq('Apple Inc')
      expect(stock.current_price).to eq(344.62)
      expect(stock.quantity).to eq(2.0)
      end
  end
end
