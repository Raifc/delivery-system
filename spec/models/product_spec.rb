require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'false when code is empty' do
      product = Product.new(code: '', height: '1.0', width: '1.0', depth: '1.0', weight: '1.0')

      product.valid?
      result = product.errors.include?(:code)

      expect(result).to be true
    end

    it 'should create a new product' do
      product = Product.new(code: '100', height: '1.0', width: '1.0', depth: '1.0', weight: '1.0')
      expect(product).to be_valid
    end

  end
end
