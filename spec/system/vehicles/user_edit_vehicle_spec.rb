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
    click_on 'Vehicles'
    click_on 'Show this vehicle'
    click_on 'Edit this vehicle'
    expect(current_path).to eq '/companies/1/vehicles/1/edit'

    fill_in 'License plate', with: 'APB2202'
    fill_in 'Brand', with: 'Dodge'
    fill_in 'Model', with: 'Ram'
    fill_in 'Year', with: '2020'
    fill_in 'Load capacity', with: '4000'
    click_on 'Submit'

    expect(current_path).to eq '/companies/1/vehicles'

    expect(page).to have_content 'Vehicle successfully updated'
    within 'table' do
      expect(current_path).to eq '/companies/1/vehicles'
      expect(page).to have_content 'License Plate'
      expect(page).to have_content 'APB2202'
      expect(page).to have_content 'Brand'
      expect(page).to have_content 'Dodge'
      expect(page).to have_content 'Model'
      expect(page).to have_content 'Ram'
      expect(page).to have_content 'Year'
      expect(page).to have_content '2020'
      expect(page).to have_content 'Load Capacity'
      expect(page).to have_content '4000'
    end
  end

  it 'should not update vehicle with an empty license plate' do
    Vehicle.create!(license_plate: 'EJK2098', brand: 'Volkswagen', model: 'Cargo', year: '2022', load_capacity: '2000', company: company)

    visit company_path(user.company)
    click_on 'Vehicles'
    click_on 'Show this vehicle'
    click_on 'Edit this vehicle'
    expect(current_path).to eq '/companies/1/vehicles/1/edit'

    fill_in 'License plate', with: ''
    fill_in 'Brand', with: 'Dodge'
    fill_in 'Model', with: 'Ram'
    fill_in 'Year', with: '2020'
    fill_in 'Load capacity', with: '4000'
    click_on 'Submit'

    expect(page).to have_content 'Vehicle not updated'
    expect(page).to have_content "License plate can't be blank"
  end

end
