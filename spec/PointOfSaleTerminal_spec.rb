require 'spec_helper'
require 'PointOfSaleTerminal'

describe 'PointOfSaleTerminal' do
  describe 'control examples' do
    
    before do
      terminal.set_products(
        Products.new(
          Product.new('A', 1.00),
          Product.new('B', 3.50),
          Product.new('C', 1.50),
          Product.new('D', 0.75),
          Product.new('FF', 0.07)
        )
      )
    end

    context "ABCDABA total"  do
      let!(:terminal) { PointOfSaleTerminal.new(ASetPricing, CSetPricing) }

      it 'total should be $12.00' do
        terminal.scan('A')
        terminal.scan('B')
        terminal.scan('C')
        terminal.scan('D')
        terminal.scan('A')
        terminal.scan('B')
        terminal.scan('A')

        terminal.total.should == 12.00
      end
    end

    context "AAAAAAAA total" do
      let!(:terminal) { PointOfSaleTerminal.new(ASetPricing) }

      it 'total should be $7.50' do
        terminal.scan('A')
        terminal.scan('A')
        terminal.scan('A')
        terminal.scan('A')
        terminal.scan('A')
        terminal.scan('A')
        terminal.scan('A')
        terminal.scan('A')

        terminal.total.should == 7.50
      end
    end

    context "ABFFCD total" do
      let!(:terminal) { PointOfSaleTerminal.new(FFSetPricing) }

      it 'total should be $6.28' do
        terminal.scan('A')
        terminal.scan('B')
        terminal.scan('FF')
        terminal.scan('C')
        terminal.scan('D')

        terminal.total.should == 6.28
      end
    end
  end

  describe 'Units' do
    describe 'ShoppingCart' do
      it 'calculates total' do
        cart = ShoppingCart.new

        cart.add(Product.new('A', 1.00))
        cart.add(Product.new('C', 1.50))

        cart.total.should == 2.50
      end
    end
  end
end