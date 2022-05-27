require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe '#valid?' do
    it 'should create a new service order' do
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
      address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'transportes.com')
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      service_order = ServiceOrder.new(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)

      expect(service_order).to be_valid
    end

    it 'should not create a new service order with empty origin address' do
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
      address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'transportes.com')
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
      service_order = ServiceOrder.new(company_id: 1, destination_address_id: 3, product_id: 1)

      expect(service_order).not_to be_valid
    end

    it 'should create a new service order with empty destination address' do
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
      address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'transportes.com')
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      service_order = ServiceOrder.new(company_id: 1, origin_address_id: 2, product_id: 1)

      expect(service_order).not_to be_valid
    end

    it 'should not create a new service order without a company' do
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
      address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'transportes.com')
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
      service_order = ServiceOrder.new(origin_address_id: 2, destination_address_id: 3, product_id: 1)

      expect(service_order).not_to be_valid
    end

    it 'should not create a new service order without a product' do
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
      address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'transportes.com')
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      service_order = ServiceOrder.new(company_id: 1, origin_address_id: 2, destination_address_id: 3)

      expect(service_order).not_to be_valid
    end

  end

end
