require 'rails_helper'

describe 'User creates vehicles' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should create a new vehicle' do

    visit company_path(user.company)
    click_on 'Veículos'
    click_on 'Novo veículo'
    expect(current_path).to eq '/companies/1/vehicles/new'
    fill_in 'Placa', with: 'ABC1234'
    fill_in 'Fabricante', with: 'Ford'
    fill_in 'Modelo', with: 'F4000'
    fill_in 'Ano', with: '2009'
    fill_in 'Capacidade de carga', with: '3000'
    click_on 'Criar Veículo'

    expect(page).to have_content 'Veículo criado com sucesso!'
    within 'table' do
      expect(current_path).to eq '/companies/1/vehicles'
      expect(page).to have_content 'Placa'
      expect(page).to have_content 'ABC1234'
      expect(page).to have_content 'Fabricante'
      expect(page).to have_content 'Ford'
      expect(page).to have_content 'Modelo'
      expect(page).to have_content 'F4000'
      expect(page).to have_content 'Ano'
      expect(page).to have_content '2009'
      expect(page).to have_content 'Capacidade de carga'
      expect(page).to have_content '3000'
    end
  end

  it 'should not create a new vehicle with empty license plate' do

    visit company_path(user.company)
    click_on 'Veículos'
    click_on 'Novo veículo'
    expect(current_path).to eq '/companies/1/vehicles/new'
    fill_in 'Placa', with: ''
    fill_in 'Fabricante', with: 'Ford'
    fill_in 'Modelo', with: 'F4000'
    fill_in 'Ano', with: '2009'
    fill_in 'Capacidade de carga', with: '3000'
    click_on 'Criar Veículo'

    expect(page).to have_content "Falha ao criar veículo!"
    expect(page).to have_content "Placa não pode ficar em branco"
  end

  it 'should not create a new vehicle with duplicated license plate' do
    Vehicle.create!(license_plate: 'EJK2098', brand: 'Volkswagen', model: 'Cargo', year: '2022', load_capacity: '2000', company: company)

    visit company_path(user.company)
    click_on 'Veículos'
    click_on 'Novo veículo'

    expect(current_path).to eq '/companies/1/vehicles/new'

    fill_in 'Placa', with: 'EJK2098'
    fill_in 'Fabricante', with: 'Ford'
    fill_in 'Modelo', with: 'F4000'
    fill_in 'Ano', with: '2009'
    fill_in 'Capacidade de carga', with: '3000'
    click_on 'Criar Veículo'

    expect(page).to have_content 'Falha ao criar veículo!'
    expect(page).to have_content 'Placa já está em uso'
  end

end
