require 'rails_helper'

describe 'Admin creates new Company' do
  it 'without login' do
    visit new_company_path
    expect(current_path).to eq new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'should create a new company' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Nova Transportadora'
    expect(current_path).to eq '/companies/new'
    fill_in 'Razão Social', with: 'RDV Transportes'
    fill_in 'Nome Fantasia', with: 'Rodonaves'
    fill_in 'Domínio de E-mail', with: 'rodonaves.com.br'
    fill_in 'CNPJ', with: '123334556000123'
    fill_in 'Endereço completo', with: 'Floriano Peixoto, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    select 'Ativa', from: 'Status'
    click_on 'Criar Transportadora'

    expect(current_path).to eq '/companies/1'
    expect(page).to have_content 'Transportadora criada com sucesso!'
    expect(page).to have_content 'CNPJ - 123334556000123'
    expect(page).to have_content 'Razão Social: RDV Transportes'
    expect(page).to have_content 'CNPJ - 123334556000123'
    expect(page).to have_content 'Status Ativa'

  end

  it 'should not create a company with empty corporate name' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Nova Transportadora'
    expect(current_path).to eq '/companies/new'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: 'Hogwarts Express'
    fill_in 'Domínio de E-mail', with: 'hogwarts.com'
    fill_in 'CNPJ', with: '58456228000196'
    fill_in 'Endereço completo', with: 'Nobody Knows, 1'
    fill_in 'Cidade', with: 'London'
    fill_in 'Estado', with: 'ln'
    select 'Ativa', from: 'Status'
    click_on 'Criar Transportadora'

    expect(page).to have_content "Falha ao criar transportadora"
    expect(page).to have_content "Razão Social não pode ficar em branco"

  end

  it 'should not create a company with duplicated registration number' do
    address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'New York')
    company = Company.create!(corporate_name: 'Monster Transports', trading_name: 'Monster', registration_number: '1234567', address: address, email_domain: 'alfa.com')

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Nova Transportadora'
    expect(current_path).to eq '/companies/new'
    fill_in 'Razão Social', with: 'London Transports'
    fill_in 'Nome Fantasia', with: 'Hogwarts Express'
    fill_in 'Domínio de E-mail', with: 'hogwarts.com'
    fill_in 'CNPJ', with: '1234567'
    fill_in 'Endereço completo', with: 'Nobody Knows, 1'
    fill_in 'Cidade', with: 'London'
    fill_in 'Estado', with: 'ln'
    select 'Ativa', from: 'Status'
    click_on 'Criar Transportadora'

    expect(page).to have_content 'Falha ao criar transportadora'
    expect(page).to have_content 'CNPJ já está em uso'

  end

  it 'should not create a company with empty full address informations' do

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Nova Transportadora'
    expect(current_path).to eq '/companies/new'
    fill_in 'Razão Social', with: '24557895000125'
    fill_in 'Nome Fantasia', with: 'Hogwarts Express'
    fill_in 'Domínio de E-mail', with: 'hogwarts.com'
    fill_in 'CNPJ', with: '123456'
    fill_in 'Endereço completo', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    select 'Ativa', from: 'Status'
    click_on 'Criar Transportadora'

    expect(page).to have_content "Falha ao criar transportadora"
    expect(page).to have_content "Endereço completo não pode ficar em branco"
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "Estado não pode ficar em branco"
  end

  it 'should not create a company with empty email domain' do

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Nova Transportadora'
    expect(current_path).to eq '/companies/new'
    fill_in 'Razão Social', with: 'RDV Transportes'
    fill_in 'Nome Fantasia', with: 'Rodonaves'
    fill_in 'Domínio de E-mail', with: ''
    fill_in 'CNPJ', with: '123334556000123'
    fill_in 'Endereço completo', with: 'Floriano Peixoto, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    select 'Ativa', from: 'Status'
    click_on 'Criar Transportadora'

    expect(page).to have_content "Falha ao criar transportadora"
    expect(page).to have_content "Domínio de E-mail não é válido"
  end

end
