require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'false when full address name is empty' do
      address = Address.new(full_address: '', city: 'New York', state: 'New York')

      address.valid?
      result = address.errors.include?(:full_address)

      expect(result).to be true
    end

    it 'should create a new address' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')

      expect(address).to be_valid
    end

  end
end
