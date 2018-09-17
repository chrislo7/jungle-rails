require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "should save successfully when validations are met" do
      @category = Category.new
      @product = Product.new ({name: 'Blue Bookshelf', price: 123321, quantity: 1, category: @category})
      expect(@product.save).to eq(true)
    end

    it "should have a name" do
      @category = Category.new
      @product = Product.new ({name: nil, price: 456654, quantity: 2, category: @category})
      @product.save
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it "should have a price" do
      @category = Category.new
      @product = Product.new ({name: 'Rspec Revolver', price: nil, quantity: 3, category: @category})
      @product.save
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it "should have a quantity" do
      @category = Category.new
      @product = Product.new ({name: 'JavaScript Scripture', price: 789987, quantity: nil, category: @category})
      @product.save
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "should have a category" do
      @category = Category.new
      @product = Product.new ({name: 'Rspec Revolver', price: 134431, quantity: 4, category: nil})
      @product.save
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end

