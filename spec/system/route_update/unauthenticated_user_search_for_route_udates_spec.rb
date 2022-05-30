require 'rails_helper'

describe 'unauthenticated user search for route updates' do

  let!(:company) {
    Address.create!(full_address: 'Marginal Tiete', city: 'São Paulo', state: 'SP')
    Address.create!(full_address: 'Av Getulio Vargas', city: 'Uberlandia', state: 'MG')
    @address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'NY')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'transportes.com')
    Product.create!(code: 'SKAUV15', height: 3, width: 55, depth: 12, weight: 24)
    service_order = ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
    @time = Time.current.end_of_day
    RouteUpdate.create!(city: 'Ribeirão Preto', time: @time, service_order_id: 1)
    @code = service_order.code
  }

  it 'and see the results' do
    visit root_path
    fill_in 'Buscar', with: @code.to_s
    click_on 'Enviar'

    expect(page).to have_content 'Data'
    expect(page).to have_content "#{@time}"
    expect(page).to have_content 'Cidade'
    expect(page).to have_content 'Ribeirão Preto'
  end

  it 'and does not fill the field' do
    visit root_path
    fill_in 'Buscar', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não encontrado'
  end

  it 'and fills de field with wrong code' do
    visit root_path
    fill_in 'Buscar', with: 'MJVMVDKAW1EAUMS'
    click_on 'Enviar'

    expect(page).to have_content 'Não encontrado'
  end

  it 'and there are no route updates yet' do
    Company.create!(corporate_name: 'Monster', trading_name: 'Monster Transports', registration_number: '145225879', address: @address, email_domain: 'transportes.com')
    service_order = ServiceOrder.create!(company_id: 1, origin_address_id: 2, destination_address_id: 3, product_id: 1)
    code = service_order.code

    visit root_path
    fill_in 'Buscar', with: code.to_s
    click_on 'Enviar'

    expect(page).to have_content 'Não encontrado'
  end

end
