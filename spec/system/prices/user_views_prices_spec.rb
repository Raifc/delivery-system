require 'rails_helper'

describe 'User views prices - ' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should see prices' do
    Price.create!(min_volume: 1, max_volume: 3, min_weight: 1, max_weight: 10, km_value: 1, company: company)

    visit company_path(user.company)
    click_on 'Preços'

    within 'table' do
      expect(page).to have_content 'Volume mínimo'
      expect(page).to have_content '1.0cm³'
      expect(page).to have_content 'Volume máximo'
      expect(page).to have_content '3.0cm³'
      expect(page).to have_content 'Peso mínimo'
      expect(page).to have_content '1.0g'
      expect(page).to have_content 'Peso máximo'
      expect(page).to have_content '10.0g'
      expect(page).to have_content 'Valor por km'
      expect(page).to have_content 'R$0.01'
    end
  end

  it 'should not see other companies prices' do
    Company.create!(corporate_name: 'Monter', trading_name: 'Monster transports',
                    registration_number: '123456789', address: @address, email_domain: 'monster.com')

    visit '/companies/2/prices'

    expect(current_path).to eq root_path
    expect(page).to have_content('Acesso não permitido')
  end

  it 'should return to company page' do
    visit company_path(user.company)
    click_on 'Preços'
    expect(current_path).to eq '/companies/1/prices'
    click_on 'Voltar'
    expect(current_path).to eq '/companies/1'

  end

end
