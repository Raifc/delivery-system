require 'rails_helper'

describe 'User edits a vehicle - ' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end
  it 'should edit a vehicle successfully' do
    Vehicle.create!(license_plate: 'EJK2098', brand: 'Volkswagen', model: 'Cargo', year: '2022', load_capacity: '2000', company: company)

    visit company_path(user.company)
    click_on 'Veículos'
    click_on 'Ver'
    click_on 'Editar veículo'
    expect(current_path).to eq '/companies/1/vehicles/1/edit'

    fill_in 'Placa', with: 'APB2202'
    fill_in 'Fabricante', with: 'Dodge'
    fill_in 'Modelo', with: 'Ram'
    fill_in 'Ano', with: '2020'
    fill_in 'Capacidade de carga', with: '4000'
    click_on 'Atualizar Veículo'

    expect(current_path).to eq '/companies/1/vehicles'

    expect(page).to have_content 'Veículo atualizado com sucesso!'

    within 'table' do
      expect(current_path).to eq '/companies/1/vehicles'
      expect(page).to have_content 'Placa'
      expect(page).to have_content 'APB2202'
      expect(page).to have_content 'Fabricante'
      expect(page).to have_content 'Dodge'
      expect(page).to have_content 'Modelo'
      expect(page).to have_content 'Ram'
      expect(page).to have_content 'Ano'
      expect(page).to have_content '2020'
      expect(page).to have_content 'Capacidade de carga'
      expect(page).to have_content '4000'
    end
  end

  it 'should not update vehicle with an empty license plate' do
    Vehicle.create!(license_plate: 'EJK2098', brand: 'Volkswagen', model: 'Cargo', year: '2022', load_capacity: '2000', company: company)

    visit company_path(user.company)
    click_on 'Veículos'
    click_on 'Ver'
    click_on 'Editar veículo'
    expect(current_path).to eq '/companies/1/vehicles/1/edit'

    fill_in 'Placa', with: ''
    fill_in 'Fabricante', with: 'Dodge'
    fill_in 'Modelo', with: 'Ram'
    fill_in 'Ano', with: '2020'
    fill_in 'Capacidade de carga', with: '4000'
    click_on 'Atualizar Veículo'

    expect(page).to have_content "Falha ao atualizar veículo!"
    expect(page).to have_content "Placa não pode ficar em branco"
  end

end
