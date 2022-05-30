require 'rails_helper'

describe 'User creates delivery times' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should create a new delivery time' do
    visit company_path(user.company)

    click_on 'Tempo de entrega'
    click_on 'Novo Tempo de entrega'
    expect(current_path).to eq '/companies/1/delivery_times/new'
    fill_in 'Distância mínima', with: '30'
    fill_in 'Distância máxima', with: '100'
    fill_in 'Dias úteis', with: '3'
    click_on 'Criar Tempo de Entrega'

    expect(current_path).to eq '/companies/1/delivery_times'
    expect(page).to have_content 'Tempo de entrega criado!'

    within 'table' do
      expect(page).to have_content 'Distância mínima'
      expect(page).to have_content '30'
      expect(page).to have_content 'Distância máxima'
      expect(page).to have_content '100'
      expect(page).to have_content 'Dias úteis'
      expect(page).to have_content '3'
    end
  end

  it 'should not create a new delivery time with empty business days' do
    visit company_path(user.company)

    click_on 'Tempo de entrega'
    click_on 'Novo Tempo de entrega'
    expect(current_path).to eq '/companies/1/delivery_times/new'
    fill_in 'Distância mínima', with: '30'
    fill_in 'Distância máxima', with: '100'
    fill_in 'Dias úteis', with: ''
    click_on 'Criar Tempo de Entrega'

    expect(page).to have_content 'Falha ao criar novo tempo de entrega'
    expect(page).to have_content "Dias úteis não pode ficar em branco"
  end

  it 'should not create a new delivery time with min distance bigger than max distance' do
    visit company_path(user.company)

    click_on 'Tempo de entrega'
    click_on 'Novo Tempo de entrega'
    expect(current_path).to eq '/companies/1/delivery_times/new'
    fill_in 'Distância mínima', with: '400'
    fill_in 'Distância máxima', with: '100'
    fill_in 'Dias úteis', with: '5'
    click_on 'Criar Tempo de Entrega'

    expect(page).to have_content 'Falha ao criar novo tempo de entrega'
    expect(page).to have_content "Distância máxima deve ser maior que a distância mínima"
  end

  it 'should not create a new delivery time with negative min distance' do
    visit company_path(user.company)

    click_on 'Tempo de entrega'
    click_on 'Novo Tempo de entrega'
    expect(current_path).to eq '/companies/1/delivery_times/new'
    fill_in 'Distância mínima', with: '-1'
    fill_in 'Distância máxima', with: '100'
    fill_in 'Dias úteis', with: '5'
    click_on 'Criar Tempo de Entrega'

    expect(page).to have_content 'Falha ao criar novo tempo de entrega'
    expect(page).to have_content "Distância mínima deve ser maior que 0"
  end

  it 'should not create a new delivery time with negative business days' do
    visit company_path(user.company)

    click_on 'Tempo de entrega'
    click_on 'Novo Tempo de entrega'
    expect(current_path).to eq '/companies/1/delivery_times/new'
    fill_in 'Distância mínima', with: '1'
    fill_in 'Distância máxima', with: '100'
    fill_in 'Dias úteis', with: '-2'
    click_on 'Criar Tempo de Entrega'

    expect(page).to have_content 'Falha ao criar novo tempo de entrega'
    expect(page).to have_content "Dias úteis deve ser maior que 0"
  end

  it 'should not create a new delivery time if the distance range already exists' do
    DeliveryTime.create!(min_distance: '100', max_distance: '200', business_days: '3', company: company)

    visit company_path(user.company)

    click_on 'Tempo de entrega'
    click_on 'Novo Tempo de entrega'
    expect(current_path).to eq '/companies/1/delivery_times/new'
    fill_in 'Distância mínima', with: '101'
    fill_in 'Distância máxima', with: '150'
    fill_in 'Dias úteis', with: '4'
    click_on 'Criar Tempo de Entrega'

    expect(page).to have_content 'Falha ao criar novo tempo de entrega'
    expect(page).to have_content "Distância mínima já registrada!"
    expect(page).to have_content "Distância máxima já registrada!"
  end

end
