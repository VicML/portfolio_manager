require_relative '../lib/portfolio'
require_relative '../lib/stock'

RSpec.describe Portfolio do
  describe '#initialize' do
    it 'should initialize with a all values' do
      portfolio = Portfolio.new('Tech', "Global Technology")
      expect(portfolio.name).to eq('Tech')
      expect(portfolio.description).to eq("Global Technology")
      expect(portfolio.stocks).to eq({})
      expect(portfolio.allocated_stocks).to eq({})
    end
    it 'should raise an error if total stock allocation exceeds 100%' do
      expect { Portfolio.new('Tech', "Global Technology", {}, { 'AAPL' => 101.0 }) }.to raise_error(RuntimeError)
      end
  end
  describe '#rebalance' do
    it 'should rebalance the portfolio' do
      portfolio = Portfolio.new(
        'Tech',
        'Global Technology',
        {
          'AAPL' => Stock.new('AAPL', 'Apple Inc', 100.0, 8.0),
          'MSFT' => Stock.new('MSFT', 'Microsoft Corporation', 100.0, 1.0),
          'META' => Stock.new('META', 'Meta Platforms, Inc.', 100.0, 1.0)
        },
        {
          'AAPL' => 20.0,
          'MSFT' => 60.0,
          'META' => 20.0
        }
      )

      values = portfolio.rebalance

      expect(values).to eq({
                             'AAPL' => { amount: -600.0, diff: -60.0, quantity: -6.0 },
                             'META' => { amount:  100.0, diff:  10.0, quantity:  1.0 },
                             'MSFT' => { amount:  500.0, diff:  50.0, quantity:  5.0 }
                           })
    end
  end
end
