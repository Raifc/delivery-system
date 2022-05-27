require 'rails_helper'

describe 'admin creates a new service order' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:admin) { Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456') }

  before(:each) do
    login_as admin, scope: :admin
  end

  it 'successfully' do
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)

    visit('companies')
    click_on 'Show this company'
    click_on 'Service Orders'
    click_on 'New Service Order'
    fill_in 'Endereço de origem', with: 'Rua 25 de março, 100'
    fill_in 'Cidade de Origem', with: 'São Paulo'
    fill_in 'Estado de Origem', with: 'SP'
    fill_in 'Endereço de Destino', with: 'Rua goiás, 10'
    fill_in 'Cidade de Destino', with: 'Uberlândia'
    fill_in 'Estado de Destino', with: 'MG'
    select 'SKAUV15', from: 'Product Code'
    click_on 'Submit'

    expect(page).to have_content 'Service Order successfully created'
    expect(current_path).to eq '/companies/1/service_orders'
  end

end
