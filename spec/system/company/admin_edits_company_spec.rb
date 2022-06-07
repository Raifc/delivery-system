require 'rails_helper'

describe 'Admin edit a Company' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'M Transports', trading_name: 'Monster Transports', registration_number: '1234567',
                    address: @address, email_domain: 'monster.com', status: 'Ativa')
  }

  it 'without login' do
    visit new_company_path
    expect(current_path).to eq new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'successfully' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Ver'
    click_on 'Editar transportadora'
    expect(current_path).to eq '/companies/1/edit'
    fill_in 'Razão Social', with: 'Rodonaves'
    fill_in 'Nome Fantasia', with: 'Ronaves transports'
    fill_in 'CNPJ', with: '123334556000123'
    fill_in 'Endereço completo', with: 'Floriano Peixoto, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    fill_in 'Domínio de E-mail', with: 'rodonaves.com.br'
    select 'Ativa', from: 'Status'
    click_on 'Atualizar Transportadora'

    within 'table' do
      expect(page).to have_content 'Razão Social'
      expect(page).to have_content 'Rodonaves'
      expect(page).to have_content 'Nome Fantasia'
      expect(page).to have_content 'Ronaves transports'
      expect(page).to have_content 'CNPJ'
      expect(page).to have_content '123334556000123'
      expect(page).to have_content 'Status'
      expect(page).to have_content 'Ativa'
    end

  end

  it 'should not update without registration number' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Ver'
    click_on 'Editar transportadora'
    expect(current_path).to eq '/companies/1/edit'
    fill_in 'Razão Social', with: 'Rodonaves'
    fill_in 'Nome Fantasia', with: 'Ronaves transports'
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço completo', with: 'Floriano Peixoto, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    fill_in 'Domínio de E-mail', with: 'rodonaves.com.br'
    select 'Ativa', from: 'Status'
    click_on 'Atualizar Transportadora'

    expect(page).to have_content "Falha ao atualizar transportadora"
    expect(page).to have_content "CNPJ não pode ficar em branco"

  end

  it 'should not update without corporate name' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Ver'
    click_on 'Editar transportadora'
    expect(current_path).to eq '/companies/1/edit'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: 'Ronaves transports'
    fill_in 'CNPJ', with: '123334556000123'
    fill_in 'Endereço completo', with: 'Floriano Peixoto, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    fill_in 'Domínio de E-mail', with: 'rodonaves.com.br'
    select 'Ativa', from: 'Status'
    click_on 'Atualizar Transportadora'

    expect(page).to have_content "Falha ao atualizar transportadora"
    expect(page).to have_content "Razão Social não pode ficar em branco"
  end

end
