require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'false when corporate name is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
      company = Company.new(corporate_name: '', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain)
      expect(company).not_to be_valid
    end

    it 'false when address is empty' do
      email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
      company = Company.new(corporate_name: '', trading_name: 'Alfa', registration_number: '1234567', email_domain: email_domain)
      expect(company).not_to be_valid
    end

    it 'false when email domain is empty' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      company = Company.new(corporate_name: '', trading_name: 'Alfa', registration_number: '1234567', address: address)
      expect(company).not_to be_valid
    end

    it 'should create a new company' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
      email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
      company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain)
      expect(company).to be_valid
    end

  end

end