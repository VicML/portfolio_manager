class Portfolio
  attr_accessor :name, :description
  attr_accessor :stocks, :allocated_stocks

  def initialize(name, description, stocks = {}, allocated_stocks = {})
    @name = name
    @description = description
    @stocks = stocks
    total_percent = allocated_stocks.sum{ |symbol, percentage| percentage }
    raise "Total stock allocation cannot exceed 100%" if total_percent > 100
    @allocated_stocks = allocated_stocks
  end

  def distributions
    _total_value = total_value
    @stocks.map do |symbol, stock|
      [stock.symbol, (stock.current_price * stock.quantity) / total_value]
    end.to_h
  end

  def total_value
    @stocks.sum do |symbol,stock|
      stock.current_price * stock.quantity
    end
  end

  def rebalance
    _total_value = total_value
    _distributions = distributions
    rebalances = {}
    _distributions.each do |symbol, distribution|
      allocated_stock = allocated_stocks[symbol]
      if allocated_stock.nil?
        rebalances[symbol] = {diff: -distribution, ammount: distribution*_total_value}
      else
        diff = allocated_stock - distribution * 100
        amount = ( diff / 100 ) * _total_value
        rebalances[symbol] = {diff: diff, amount: amount, quantity: amount/ @stocks[symbol].current_price}
      end
    end.to_h
    rebalances
  end
end