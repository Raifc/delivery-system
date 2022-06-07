require 'rails_helper'

describe 'admin searches for price' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    company = Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
    Price.create!(min_volume: '300', max_volume: '500', min_weight: '500', max_weight: '1000', km_value: '15', company: company)
    DeliveryTime.create!(min_distance: '1', max_distance: '200', business_days: '3', company: company)
  }

  let!(:admin) { Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456') }

  before(:each) do
    login_as admin, scope: :admin
  end

  it 'should see price results' do

    visit root_path
    click_on 'Consulta de Preços'
    fill_in 'Altura do pacote (cm)', with: '7'
    fill_in 'Largura do pacote (cm)', with: '7'
    fill_in 'Profundidade do pacote (cm)', with: '7'
    fill_in 'Peso do pacote (Gramas)', with: '600'
    fill_in 'Distância (km)', with: '100'
    click_on 'Consultar Preços'

    expect(page).to have_content 'Preços para o pacote'
    within 'table' do
      expect(page).to have_content 'Transportadora'
      expect(page).to have_content 'Preço para envio'
      expect(page).to have_content 'R$15.0'
      expect(page).to have_content 'Tempo para entrega'
      expect(page).to have_content '3 Dias úteis'

    end

  end

  it 'and there are no prices registered' do

    visit root_path
    click_on 'Consulta de Preços'
    fill_in 'Altura do pacote (cm)', with: '7'
    fill_in 'Largura do pacote (cm)', with: '7'
    fill_in 'Profundidade do pacote (cm)', with: '7'
    fill_in 'Peso do pacote (Gramas)', with: '600'
    fill_in 'Distância (km)', with: '100'
    click_on 'Consultar Preços'

    expect(page).to have_content 'Transportadora'

  end

end
