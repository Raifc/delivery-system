require 'rails_helper'

describe 'User edits delivery time - ' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should update delivery time' do
    DeliveryTime.create!(min_distance: '30', max_distance: '50', business_days: '4', company: company)

    visit company_path(user.company)

    click_on 'Tempo de entrega'
    click_on 'Mostrar'
    click_on 'Editar'
    expect(current_path).to eq '/companies/1/delivery_times/1/edit'
    fill_in 'Distância mínima', with: '5'
    fill_in 'Distância máxima', with: '50'
    fill_in 'Dias úteis', with: '2'
    click_on 'Atualizar Tempo de Entrega'

    expect(page).to have_content 'Tempo de entrega atualizado!'
    within 'table' do
      expect(page).to have_content 'Distância mínima'
      expect(page).to have_content '5'
      expect(page).to have_content 'Distância máxima'
      expect(page).to have_content '50'
      expect(page).to have_content 'Dias úteis'
      expect(page).to have_content '2'
    end
  end

  it 'should update delivery time with empty maximum distance' do
    DeliveryTime.create!(min_distance: '30', max_distance: '50', business_days: '4', company: company)

    visit company_path(user.company)
    click_on 'Tempo de entrega'
    click_on 'Mostrar'
    click_on 'Editar'
    expect(current_path).to eq '/companies/1/delivery_times/1/edit'
    fill_in 'Distância mínima', with: '5'
    fill_in 'Distância máxima', with: ''
    fill_in 'Dias úteis', with: '2'
    click_on 'Atualizar Tempo de Entrega'

    expect(page).to have_content "Falha ao atualizar tempo de entrega!"
    expect(page).to have_content "Distância máxima não pode ficar em branco"
  end

end
