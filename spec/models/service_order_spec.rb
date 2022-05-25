require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe '#valid?' do
    it 'should create a new service order' do
      first_address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Address.create!(full_address: 'R dos jasmins', city: 'Uberlandia', state: 'MG')
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      email_domain = EmailDomain.create!(domain: 'alfa@alfa.com')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: first_address, email_domain: email_domain)
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      service_order = ServiceOrder.new(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
      expect(service_order).to be_valid
    end

    it 'should not create a new service order with empty origin address' do
      first_address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Address.create!(full_address: 'R dos jasmins', city: 'Uberlandia', state: 'MG')
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      email_domain = EmailDomain.create!(domain: 'alfa@alfa.com')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: first_address, email_domain: email_domain)
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      service_order = ServiceOrder.new(company_id: 1, destination_address_id: 3, product_id: 1)
      expect(service_order).not_to be_valid
    end

    it 'should not create a new service order without a company' do
      first_address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
      Address.create!(full_address: 'R dos jasmins', city: 'Uberlandia', state: 'MG')
      Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
      email_domain = EmailDomain.create!(domain: 'alfa@alfa.com')
      Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: first_address, email_domain: email_domain)
      Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
      service_order = ServiceOrder.new(origin_address_id: 2, destination_address_id: 3, product_id: 1)

      expect(service_order).not_to be_valid
    end
  end

end
