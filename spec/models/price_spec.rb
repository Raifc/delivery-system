require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'should create a new price' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'alfa.com')
      price = Price.new(min_volume: '1', max_volume: '2', min_weight: '3', max_weight: '4', km_value: '5', company: company)
      expect(price).to be_valid
    end

    it 'false when company is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'alfa.com')
      price = Price.new(min_volume: '1', max_volume: '2', min_weight: '3', max_weight: '4', km_value: '5')

      expect(price).not_to be_valid
    end

    it 'false when minimum volume is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'alfa.com')
      price = Price.new(min_volume: '', max_volume: '2', min_weight: '3', max_weight: '4', km_value: '5', company: company)

      expect(price).not_to be_valid
    end

  end
end
