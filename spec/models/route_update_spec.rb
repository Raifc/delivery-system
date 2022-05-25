require 'rails_helper'

RSpec.describe RouteUpdate, type: :model do
  describe '#valid?' do
    it 'should create a new route update' do
      first_address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Address.create!(full_address: 'R dos jasmins', city: 'Uberlandia', state: 'MG')
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      email_domain = EmailDomain.create!(domain: 'alfa@alfa.com')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: first_address, email_domain: email_domain)
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
      route_update = RouteUpdate.new(city: 'Ribeirão Preto', time: Time.now, service_order_id: 1)

      expect(route_update).to be_valid
    end

    it 'should not create a new route update without a city' do
      first_address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Address.create!(full_address: 'R dos jasmins', city: 'Uberlandia', state: 'MG')
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      email_domain = EmailDomain.create!(domain: 'alfa@alfa.com')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: first_address, email_domain: email_domain)
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
      route_update = RouteUpdate.new(time: Time.now, service_order_id: 1)

      expect(route_update).not_to be_valid
    end
  end
end
