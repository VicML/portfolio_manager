class Stock
  attr_accessor :current_price, :symbol, :name, :quantity

  def initialize(symbol, name, current_price, quantity)
    @symbol = symbol
    @name = name
    @current_price = current_price
    @quantity = quantity
  end
end
