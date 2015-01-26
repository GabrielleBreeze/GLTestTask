# encoding: utf-8
Product = Struct.new(:code, :price)

class Products
  include Enumerable

  def initialize(*items)
    @items = items.flatten
  end

  def each(&block)
    @items.each(&block)
  end
  
  def find_product_by_code(code)
    find { |product| product.code == code }
  end
end

class ShoppingCart
  include Enumerable
  
  def initialize
    @items = []
  end
  
  def add(item)
    @items << item
  end
  
  def each(&block)
    @items.each(&block)
  end
  
  def total
    @items.inject(0.0) do |total, product|
      total += product.price
    end
  end
end

class SetPricing
  def initialize(cart)
    @cart = cart
  end
  
  def method_missing(method, *args, &block)
    @cart.send(method, *args, &block)
  end
end

class ASetPricing < SetPricing
  def total
    wholesale_price_a = 2.75
    goods = @cart.select {|item| item.code == 'A'}
    if goods.count >= 3
      quotA, remA = goods.count.divmod(3)
      @cart.total - goods[0].price * goods.count + quotA*wholesale_price_a + remA * goods[0].price
    else
      @cart.total
    end
  end
end

class CSetPricing < SetPricing
  def total
    wholesale_price_c = 5.00
    goods = @cart.select {|item| item.code == 'С'}
    if goods.count >= 4
      quotC, remC = goods.count.divmod(4)
      @cart.total - goods[0].price * goods.count + quotC * wholesale_price_c + remC * goods[0].price
    else
      @cart.total
    end
  end
end

class FSetPricing < SetPricing
  def total
    goods = @cart.select {|item| item.code == 'F'}
    if goods.count == 1
      (@cart.total - (@cart.total - goods[0].price) / 100 * 5 - goods[0].price).round(2)
    else
      @cart.total
    end
  end
end

class FFSetPricing < SetPricing
  def total
    goods = @cart.select {|item| item.code == 'FF'}
    if goods.count == 1
      (@cart.total - (@cart.total - goods[0].price) / 100 * 7 - goods[0].price).round(2)
    else
      @cart.total
    end
  end
end

class FFFSetPricing < SetPricing
  def total
    goods = @cart.select {|item| item.code == 'FFF'}
    if goods.count == 1
      (@cart.total - (@cart.total - goods[0].price) / 100 * 10 - goods[0].price).round(2)
    else
      @cart.total
    end
  end
end

class PointOfSaleTerminal
  def initialize(*rules)
    @products = nil
    @cart = rules.inject(ShoppingCart.new) do |items, rule|
      rule.new(items)
    end
  end
  
  def set_products(products)
    @products = products
  end
  
  def scan(code)
    if @products
      product = @products.find_product_by_code(code)
      @cart.add(product) if product
    end
  end
  
  def total
    @cart.total
  end
end