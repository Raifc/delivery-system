require 'rails_helper'

describe 'User views route updates' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
    Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
    Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
    address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
    ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
    @time = Time.current.end_of_day

  }

  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'and there are no route updates' do
    visit '/companies/1/service_orders/1/route_updates'

    expect(page).to have_content 'Nenhuma atualização ainda!'

  end

  it 'should see route updates' do
    RouteUpdate.create!(city: 'Ribeirão Preto', time: @time, service_order_id: 1)

    visit company_path(user.company)
    click_on 'Ordens de Serviço'
    click_on 'Ver'
    click_on 'Atualizações de rota'
    within 'table' do
      expect(page).to have_content 'Cidade'
      expect(page).to have_content 'Ribeirão Preto'
      expect(page).to have_content 'Data e Hora'
      expect(page).to have_content @time.to_s
    end
  end

  it 'should not see other companies route updates' do
    Company.create!(corporate_name: 'Monter', trading_name: 'Monster transports',
                    registration_number: '123456789', address: @address, email_domain: 'monster.com')

    visit '/companies/2/service_orders/1/route_updates'

    expect(current_path).to eq root_path
    expect(page).to have_content('Acesso não permitido')
  end

  it 'should return to companies page' do
    visit company_path(user.company)

    click_on 'Ordens de Serviço'
    click_on 'Ver'
    click_on 'Atualizações de rota'
    click_on 'Voltar'

    expect(current_path).to eq '/companies/1'

  end

end
