require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'should create a new delivery time' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
      company = Company.new(corporate_name: 'Alfa transports', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain)
      delivery_time = DeliveryTime.new(min_distance: '100', max_distance: '200', business_days: '3', company: company)

      expect(delivery_time).to be_valid
    end

    it 'false when company is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
      delivery_time = DeliveryTime.new(min_distance: '100', max_distance: '200', business_days: '3')

      expect(delivery_time).not_to be_valid
    end

    it 'false when minimum distance is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
      company = Company.new(corporate_name: 'Alfa transports', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain)
      delivery_time = DeliveryTime.new(min_distance: '', max_distance: '200', business_days: '3', company: company)

      expect(delivery_time).not_to be_valid
    end

  end
end
