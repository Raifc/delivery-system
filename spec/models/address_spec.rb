require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'false when full address name is empty' do
      address = Address.new(full_address: '', city: 'New York', state: 'New York')

      expect(address).not_to be_valid
    end

    it 'should create a new address' do
      address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')

      expect(address).to be_valid
    end

  end
end
