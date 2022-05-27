require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'should create a new vehicle' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'alfa.com')
      vehicle = Vehicle.new(license_plate: 'ABF123', brand: 'Volkswagen', model: 'Van', year: '1992', load_capacity: '200', company: company)

      expect(vehicle).to be_valid
    end

    it 'should not create a new vehicle without a company' do
      vehicle = Vehicle.new(license_plate: 'ABF123', brand: 'Volkswagen', model: 'Van', year: '1992', load_capacity: '200')
      expect(vehicle).not_to be_valid
    end

    it 'should not create a new vehicle with empty license plate' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'alfa.com')
      vehicle = Vehicle.new(license_plate: '', brand: 'Volkswagen', model: 'Van', year: '1992', load_capacity: '200', company: company)

      expect(vehicle).not_to be_valid
    end

    it 'should not create a new vehicle with duplicated license plate' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'alfa.com')
      Vehicle.create!(license_plate: 'OLK1515', brand: 'Volkswagen', model: 'Volks Van', year: '1992', load_capacity: '2000', company: company)
      vehicle = Vehicle.new(license_plate: 'OLK1515', brand: 'Citroen', model: 'Citroen Van', year: '2020', load_capacity: '4000', company: company)

      expect(vehicle).not_to be_valid
    end

    it 'should not create a new vehicle with empty load capacity' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: 'alfa.com')
      vehicle = Vehicle.new(license_plate: 'KKL1213', brand: 'Volkswagen', model: 'Van', year: '1992', load_capacity: '', company: company)

      expect(vehicle).not_to be_valid
    end

  end
end
