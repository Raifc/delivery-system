require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'should create a new delivery time' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'alfa.com')
      delivery_time = DeliveryTime.new(min_distance: '100', max_distance: '200', business_days: '3', company: company)

      expect(delivery_time).to be_valid
    end

    it 'false when company is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      delivery_time = DeliveryTime.new(min_distance: '100', max_distance: '200', business_days: '3')

      expect(delivery_time).not_to be_valid
    end

    it 'false when minimum distance is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'alfa.com')
      delivery_time = DeliveryTime.new(min_distance: '', max_distance: '200', business_days: '3', company: company)

      expect(delivery_time).not_to be_valid
    end

  end
end
