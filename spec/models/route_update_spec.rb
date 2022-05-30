require 'rails_helper'

RSpec.describe RouteUpdate, type: :model do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567',
                    address: @address, email_domain: 'alfa.com')
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
    Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
    Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
    ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
  }

  describe '#valid?' do
    it 'should create a new route update' do
      route_update = RouteUpdate.new(city: 'Ribeirão Preto', time: Time.current.end_of_day, service_order_id: 1)

      expect(route_update).to be_valid
    end

    it 'should not create a new route update without a city' do
      route_update = RouteUpdate.new(city: '', time: Time.current.end_of_day, service_order_id: 1)

      route_update.valid?
      result = route_update.errors.include?(:city)

      expect(result).to be true
    end

    it 'should not create a new route update without time' do
      route_update = RouteUpdate.new(city: 'Ribeirão Preto', service_order_id: 1)

      route_update.valid?
      result = route_update.errors.include?(:time)

      expect(result).to be true
    end

    it 'should not create a new route update with past time' do
      route_update = RouteUpdate.new(city: 'Ribeirão Preto', service_order_id: 1, time: Time.current.beginning_of_day)

      route_update.valid?
      result = route_update.errors.include?(:time)

      expect(result).to be true
    end
  end

end
