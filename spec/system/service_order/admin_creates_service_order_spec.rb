require 'rails_helper'

describe 'admin creates a new service order' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    @company = Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567',
                               address: @address, email_domain: 'alfa.com')
  }
  let!(:admin) { Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456') }

  before(:each) do
    login_as admin, scope: :admin
  end

  it 'should create a new service order with the right product' do
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
    Product.create!(code: 'SKU203212', height: 3, width: 55, depth: 12, weight: 24)
    allow(SecureRandom).to receive(:alphanumeric).and_return('AVF48RWHU8A4B15')

    visit('companies')
    click_on 'Ver'
    click_on 'Ordens de Serviço'
    click_on 'Nova ordem de serviço'
    fill_in 'Endereço de origem', with: 'Rua 25 de março, 100'
    fill_in 'Cidade de origem', with: 'São Paulo'
    fill_in 'Estado de origem', with: 'SP'
    fill_in 'Endereço de destino', with: 'Rua goiás, 10'
    fill_in 'Cidade de destino', with: 'Uberlândia'
    fill_in 'Estado de destino', with: 'MG'
    select 'SKAUV15', from: 'Código do produto'
    click_on 'Criar Ordem de serviço'

    expect(page).to have_content 'Ordem de serviço criada com sucesso!'

    within 'table' do
      expect(page).to have_content 'Código'
      expect(page).to have_content 'AVF48RWHU8A4B15'
      expect(page).to have_content 'Status'
      expect(page).to have_content 'Pendente'
      expect(page).to have_content 'Produto'
      expect(page).to have_content 'SKAUV15'
    end

    expect(current_path).to eq '/companies/1/service_orders'
  end

  it 'should not see link to new service order on inactive company' do
    @company.Inativa!

    visit('companies')
    click_on 'Ver'
    click_on 'Ordens de Serviço'

    expect(page).to_not have_content('Nova ordem de serviço')
  end

  it 'should not create a new service order with empty origin address' do
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)

    visit('companies')
    click_on 'Ver'
    click_on 'Ordens de Serviço'
    click_on 'Nova ordem de serviço'
    fill_in 'Endereço de origem', with: ''
    fill_in 'Cidade de origem', with: 'São Paulo'
    fill_in 'Estado de origem', with: 'SP'
    fill_in 'Endereço de destino', with: 'Rua goiás, 10'
    fill_in 'Cidade de destino', with: 'Uberlândia'
    fill_in 'Estado de destino', with: 'MG'
    select 'SKAUV15', from: 'Código do produto'
    click_on 'Criar Ordem de serviço'

    expect(page).to have_content 'Falha ao criar ordem de serviço'
    expect(page).to have_content 'Endereço completo não pode ficar em branco'
    expect(current_path).to eq '/companies/1/service_orders'
  end

  it 'should not create a new service order with empty destination address' do
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)

    visit('companies')
    click_on 'Ver'
    click_on 'Ordens de Serviço'
    click_on 'Nova ordem de serviço'
    fill_in 'Endereço de origem', with: 'Av paulista'
    fill_in 'Cidade de origem', with: 'São Paulo'
    fill_in 'Estado de origem', with: 'SP'
    fill_in 'Endereço de destino', with: ''
    fill_in 'Cidade de destino', with: 'Uberlândia'
    fill_in 'Estado de destino', with: 'MG'
    select 'SKAUV15', from: 'Código do produto'
    click_on 'Criar Ordem de serviço'

    expect(page).to have_content 'Falha ao criar ordem de serviço'
    expect(page).to have_content 'Endereço completo não pode ficar em branco'
    expect(current_path).to eq '/companies/1/service_orders'
  end

end
