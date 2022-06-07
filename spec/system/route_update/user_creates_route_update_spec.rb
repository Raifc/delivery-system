require 'rails_helper'

describe 'User creates route updates' do

  let!(:route_update) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
    Address.create!(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Address.create!(full_address: 'Av rondom pacheco', city: 'Uberlandia', state: 'MG')
    ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
    @time = Time.current.end_of_day
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should create a new route update' do
    visit company_path(user.company)
    click_on 'Ordens de Serviço'
    expect(current_path).to eq '/companies/1/service_orders'
    click_on 'Ver'
    click_on 'Atualizações de rota'
    click_on 'Nova atualização de rota'
    fill_in 'Cidade', with: 'Curitiba'
    fill_in 'Data e Hora', with: @time.to_s
    click_on 'Criar Atualização de rota'

    expect(page).to have_content 'Atualização de rota criada com sucesso!'

  end

  it 'should not create a route update with empty city' do
    visit company_path(user.company)
    click_on 'Ordens de Serviço'
    expect(current_path).to eq '/companies/1/service_orders'
    click_on 'Ver'
    click_on 'Atualizações de rota'
    click_on 'Nova atualização de rota'
    fill_in 'Cidade', with: ''
    fill_in 'Data e Hora', with: @time.to_s
    click_on 'Criar Atualização de rota'

    expect(page).to have_content 'Falha ao criar atualização de rota'
    expect(page).to have_content 'Cidade não pode ficar em branco'

  end

  it 'should fail with empty date and time' do
    visit company_path(user.company)
    click_on 'Ordens de Serviço'
    expect(current_path).to eq '/companies/1/service_orders'
    click_on 'Ver'
    click_on 'Atualizações de rota'
    click_on 'Nova atualização de rota'
    fill_in 'Cidade', with: 'London'
    fill_in 'Data e Hora', with: ''
    click_on 'Criar Atualização de rota'

    expect(page).to have_content 'Falha ao criar atualização de rota'
    expect(page).to have_content 'Data e Hora não pode ficar em branco'

  end

  it 'should fail with past date and time' do
    visit company_path(user.company)
    click_on 'Ordens de Serviço'
    expect(current_path).to eq '/companies/1/service_orders'
    click_on 'Ver'
    click_on 'Atualizações de rota'
    click_on 'Nova atualização de rota'
    fill_in 'Cidade', with: 'London'
    fill_in 'Data e Hora', with: Time.current.beginning_of_day
    click_on 'Criar Atualização de rota'

    expect(page).to have_content 'Falha ao criar atualização de rota'
    expect(page).to have_content 'Data e Hora devem ser maiores ou iguais a atual'

  end

end
