require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'false when corporate name is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: '', trading_name: 'Alfa',
                            registration_number: '1234567', address: address, email_domain: 'alfa.com')

      company.valid?
      result = company.errors.include?(:corporate_name)

      expect(result).to be true
    end

    it 'false when address is empty' do
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa',
                            registration_number: '1234567', email_domain: 'alfa.com')

      company.valid?
      result = company.errors.include?(:address)

      expect(result).to be true
    end

    it 'false when email domain is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa',
                            registration_number: '1234567', address: address, email_domain: '')

      company.valid?
      result = company.errors.include?(:email_domain)

      expect(result).to be true
    end

    it 'should create a new company' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa',
                            registration_number: '1234567', address: address, email_domain: 'alfa.com')

      expect(company).to be_valid
    end

  end

end
