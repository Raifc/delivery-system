require 'rails_helper'

describe 'User Login' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'and is associated with its company' do
    visit company_path(user.company)

    within 'table' do
      expect(page).to have_content 'Razão Social'
      expect(page).to have_content 'Beta'
      expect(page).to have_content 'Nome Fantasia'
      expect(page).to have_content 'Alfa'
      expect(page).to have_content 'CNPJ'
      expect(page).to have_content '1234567'
      expect(page).to have_content 'Status'
      expect(page).to have_content 'Ativa'
    end

  end

  it 'and sees related links' do
    visit company_path(user.company)

    expect(page).to have_link 'Veículos'
    expect(page).to have_link 'Preços'
    expect(page).to have_link 'Tempo de entrega'
    expect(page).to have_link 'Ordens de Serviço'
  end

  it 'and there are no companies with the given email address' do
    visit root_path
    click_on 'Sair'
    click_on 'Login - Usuário'
    click_on 'Sign up'
    fill_in 'E-mail', with: 'user@somecompany.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content 'Não existem transportadoras com o domínio de email informado!'
  end
end
