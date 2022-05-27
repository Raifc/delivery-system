require 'rails_helper'

RSpec.describe RouteUpdate, type: :model do
  describe '#valid?' do
    it 'should create a new route update' do
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
      address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'transportes.com')
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
      route_update = RouteUpdate.new(city: 'Ribeirão Preto', time: Time.now, service_order_id: 1)

      expect(route_update).to be_valid
    end

    it 'should not create a new route update without a city' do
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
      address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'transportes.com')
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
      route_update = RouteUpdate.new(city: '', time: Time.now, service_order_id: 1)

      expect(route_update).not_to be_valid
    end

    it 'should not create a new route update without time' do
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
      address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'transportes.com')
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
      route_update = RouteUpdate.new(city: 'Ribeirão Preto', service_order_id: 1)

      expect(route_update).not_to be_valid
    end
  end

end
