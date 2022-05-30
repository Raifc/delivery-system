require 'rails_helper'

describe 'Admin Logs in' do
  it 'and sees related links' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'M Transports', trading_name: 'Monster Transports', registration_number: '1234567',
                    address: address, email_domain: 'monster.com', status: 'Ativa')

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin
    visit('companies')

    expect(page).to have_link 'Nova Transportadora'
    expect(page).to have_link 'Produtos'

  end

end
