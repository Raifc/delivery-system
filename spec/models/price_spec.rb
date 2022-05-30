require 'rails_helper'

RSpec.describe Price, type: :model do

  describe '#valid?' do

    let!(:company) {
      @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      @company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
    }
    context 'presence'
    it 'should create a new price' do
      price = Price.new(min_volume: '1', max_volume: '2', min_weight: '3', max_weight: '4', km_value: '5', company: @company)
      expect(price).to be_valid
    end

    it 'false when company is empty' do
      price = Price.new(min_volume: '1', max_volume: '2', min_weight: '3', max_weight: '4', km_value: '5')

      price.valid?
      result = price.errors.include?(:company)

      expect(result).to be true
    end

    it 'false when minimum volume is empty' do
      price = Price.new(min_volume: '', max_volume: '2', min_weight: '3', max_weight: '4', km_value: '5', company: @company)

      price.valid?
      result = price.errors.include?(:min_volume)

      expect(result).to be true
    end

    it 'false with min volume bigger than max volume' do
      price = Price.new(min_volume: '10', max_volume: '5', min_weight: '3', max_weight: '4', km_value: '5', company: @company)

      price.valid?
      result = price.errors.include?(:max_volume)

      expect(result).to be true

    end

    it 'false with min volume bigger than max volume' do
      price = Price.new(min_volume: '1', max_volume: '50', min_weight: '300', max_weight: '10', km_value: '5', company: @company)

      price.valid?
      result = price.errors.include?(:max_weight)

      expect(result).to be true

    end

  end
end
