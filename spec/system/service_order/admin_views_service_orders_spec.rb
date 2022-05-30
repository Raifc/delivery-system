require 'rails_helper'

describe 'admin views a new service order' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567',
                    address: @address, email_domain: 'alfa.com')
  }
  let!(:admin) { Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456') }

  before(:each) do
    login_as admin, scope: :admin
  end

  it 'and see service orders' do
    Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
    Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
    service_order = ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
    codigo = service_order.code

    visit '/companies/1/service_orders'
    click_on 'Ver'

    within 'table' do
      expect(page).to have_content 'Código'
      expect(page).to have_content "#{codigo}"
      expect(page).to have_content 'Status'
      expect(page).to have_content 'Pendente'
      expect(page).to have_content 'Endereço de origem'
      expect(page).to have_content 'Av Getulio Vargas'
      expect(page).to have_content 'Cidade de origem'
      expect(page).to have_content 'Uberlandia'
      expect(page).to have_content 'Endereço de destino'
      expect(page).to have_content 'Marginal Tiete'
      expect(page).to have_content 'Cidade de destino'
      expect(page).to have_content 'São Paulo'

    end

  end

  it 'and there are no service orders created' do
    visit('companies')
    click_on 'Ver'
    click_on 'Ordens de Serviço'
    expect(page).to have_content 'Nenhuma ordem de serviço!'
  end

  it 'and returns to companies' do
    visit '/companies/1/service_orders'
    click_on 'Voltar'
    expect(current_path).to eq '/companies/1'
  end

end
