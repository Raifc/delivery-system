require 'rails_helper'

describe 'User edits prices - ' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should edit a price successfully' do
    Price.create!(min_volume: 1, max_volume: 3, min_weight: 1, max_weight: 10, km_value: 1, company: company)
    visit company_path(user.company)

    click_on 'Preços'
    click_on 'Ver'
    click_on 'Editar'
    expect(current_path).to eq '/companies/1/prices/1/edit'
    fill_in 'Volume mínimo', with: '10'
    fill_in 'Volume máximo', with: '30'
    fill_in 'Peso mínimo', with: '3'
    fill_in 'Peso máximo', with: '10'
    fill_in 'Valor por km', with: '3'
    click_on 'Atualizar Preço'

    expect(current_path).to eq '/companies/1/prices'
    expect(page).to have_content 'Preço atualizado com sucesso'

    within 'table' do
      expect(page).to have_content 'Volume mínimo'
      expect(page).to have_content '10.0cm³'
      expect(page).to have_content 'Volume máximo'
      expect(page).to have_content '30.0cm³'
      expect(page).to have_content 'Peso mínimo'
      expect(page).to have_content '3.0g'
      expect(page).to have_content 'Peso máximo'
      expect(page).to have_content '10.0g'
      expect(page).to have_content 'Valor por km'
      expect(page).to have_content 'R$0.03'
    end
  end

  it 'should not update price with empty maximum weight' do
    Price.create!(min_volume: 1, max_volume: 3, min_weight: 1, max_weight: 10, km_value: 1, company: company)

    visit company_path(user.company)
    click_on 'Preços'
    click_on 'Ver'
    click_on 'Editar'
    expect(current_path).to eq '/companies/1/prices/1/edit'

    fill_in 'Volume mínimo', with: '10'
    fill_in 'Volume máximo', with: '30'
    fill_in 'Peso mínimo', with: '3'
    fill_in 'Peso máximo', with: ''
    fill_in 'Valor por km', with: '3'
    click_on 'Atualizar Preço'

    expect(page).to have_content 'Falha ao atualizar preço'
    expect(page).to have_content "Peso máximo não pode ficar em branco"
  end

end
