require 'rails_helper'

describe 'user reviews service order' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    @company = Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567',
                               address: @address, email_domain: 'alfa.com')
    Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
    Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
    @service_order = ServiceOrder.create!(company_id: @company.id, origin_address_id: 2, destination_address_id: 3, product_id: 1)
    @code = @service_order.code
    Vehicle.create!(license_plate: 'ABF123', brand: 'Volkswagen', model: 'Van', year: '1992', load_capacity: '200', company: @company)
  }

  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should accept service order successfully' do
    visit company_path(user.company)
    click_on 'Ordens de Serviço'
    click_on 'Ver'
    expect(current_path).to eq '/companies/1/service_orders/1'
    click_on 'Revisar'
    select 'Aceita', from: 'Status'
    select 'ABF123', from: 'Veículo'
    click_on 'Atualizar Ordem de serviço'

    expect(page).to have_content 'Ordem de serviço atualizada com sucesso!'
    within 'table' do
      expect(page).to have_content 'Código'
      expect(page).to have_content @code.to_s
      expect(page).to have_content 'Status'
      expect(page).to have_content 'Aceita'
    end
  end

  it 'should reject service order successfully' do
    visit company_path(user.company)
    click_on 'Ordens de Serviço'
    click_on 'Ver'
    expect(current_path).to eq '/companies/1/service_orders/1'
    click_on 'Revisar'
    select 'Recusada', from: 'Status'
    select 'ABF123', from: 'Veículo'
    click_on 'Atualizar Ordem de serviço'

    expect(page).to have_content 'Ordem de serviço atualizada com sucesso!'
    within 'table' do
      expect(page).to have_content 'Código'
      expect(page).to have_content @code.to_s
      expect(page).to have_content 'Status'
      expect(page).to have_content 'Recusada'
    end
  end

  it 'should not see other companies service orders' do
    Company.create!(corporate_name: 'Monter', trading_name: 'Monster transports',
                    registration_number: '123456789', address: @address, email_domain: 'monster.com')

    visit '/companies/2/service_orders'

    expect(current_path).to eq root_path
    expect(page).to have_content('Acesso não permitido')
  end

end


