require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'should create a new vehicle' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain)
      vehicle = Vehicle.new(license_plate: 'ABF123', brand: 'Volkswagen', model: 'Van', year: '1992', load_capacity:'200', company: company)

      expect(vehicle).to be_valid


    end
  end
end
