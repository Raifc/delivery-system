require 'rails_helper'

describe 'User views delivery time - ' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should see delivery times' do
    DeliveryTime.create!(min_distance: '30', max_distance: '50', business_days: '4', company: company)
    visit company_path(user.company)
    click_on 'Tempo de entrega'

    within 'table' do
      expect(page).to have_content 'Distância mínima'
      expect(page).to have_content '30'
      expect(page).to have_content 'Distância máxima'
      expect(page).to have_content '50'
      expect(page).to have_content 'Dias úteis'
      expect(page).to have_content '4'
    end
  end

  it 'and returns to company page' do
    DeliveryTime.create!(min_distance: '30', max_distance: '50', business_days: '4', company: company)
    visit company_path(user.company)
    click_on 'Tempo de entrega'
    click_on 'Voltar'

    expect(current_path).to eq '/companies/1'
  end

end
