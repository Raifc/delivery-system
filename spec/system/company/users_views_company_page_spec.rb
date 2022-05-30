require 'rails_helper'

describe 'User views companies' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should see the company infos' do
    visit company_path(user.company)

    expect(page).to have_content 'Transportadora Alfa'
    expect(page).to have_content 'Razão Social: Beta'
    expect(page).to have_content ' Nome Fantasia - Alfa'
    expect(page).to have_content 'CNPJ - 1234567'
    expect(page).to have_content 'Status Ativa'
  end

  it 'should see related links' do
    visit company_path(user.company)

    expect(page).to have_link('Veículos')
    expect(page).to have_link('Preços')
    expect(page).to have_link('Tempo de entrega')
    expect(page).to have_link('Ordens de Serviço')
  end

end

