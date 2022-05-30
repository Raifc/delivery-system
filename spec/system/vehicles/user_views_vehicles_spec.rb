require 'rails_helper'

describe 'User views vehicles' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    company = Company.create!(corporate_name: 'Hogwarts', trading_name: 'Hogwarts Express', registration_number: '13456234567', address: @address, email_domain: 'hog.com')
    Vehicle.create!(license_plate: 'EJK2098', brand: 'Volkswagen', model: 'Cargo', year: '2022', load_capacity: '2000', company: company)
  }
  let!(:user) { User.create!(email: 'user@hog.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should see vehicles' do
    visit company_path(user.company)
    click_on 'Veículos'

    within 'table' do
      expect(current_path).to eq '/companies/1/vehicles'
      expect(page).to have_content 'Placa'
      expect(page).to have_content 'EJK2098'
      expect(page).to have_content 'Fabricante'
      expect(page).to have_content 'Volkswagen'
      expect(page).to have_content 'Modelo'
      expect(page).to have_content 'Cargo'
      expect(page).to have_content 'Ano'
      expect(page).to have_content '2022'
      expect(page).to have_content 'Capacidade de carga'
      expect(page).to have_content '2000'
    end

  end

  it 'and returns to company page' do
    visit company_path(user.company)
    click_on 'Veículos'
    click_on 'Voltar'
    expect(current_path).to eq '/companies/1'
  end

end