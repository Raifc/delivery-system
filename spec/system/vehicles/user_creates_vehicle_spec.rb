require 'rails_helper'

describe 'User creates vehicles' do
  it 'should create a new vehicle' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')

    visit('companies')
    click_on 'Show this company'
    click_on 'Vehicles'
    click_on 'New Vehicle'
    expect(current_path).to eq '/companies/1/vehicles/new'
    fill_in 'License plate', with: 'ABC1234'
    fill_in 'Brand', with: 'Ford'
    fill_in 'Model', with: 'F4000'
    fill_in 'Year', with: '2009'
    fill_in 'Load capacity', with: '3000'
    click_on 'Submit'
    expect(page).to have_content 'Vehicle successfully created'
    within 'table' do
      expect(current_path).to eq '/companies/1/vehicles'
      expect(page).to have_content 'License Plate'
      expect(page).to have_content 'ABC1234'
      expect(page).to have_content 'Brand'
      expect(page).to have_content 'Ford'
      expect(page).to have_content 'Model'
      expect(page).to have_content 'F4000'
      expect(page).to have_content 'Year'
      expect(page).to have_content '2009'
      expect(page).to have_content 'Load Capacity'
      expect(page).to have_content '3000'
    end
  end

  it 'should not create a new vehicle with empty license plate' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')

    visit('companies')
    click_on 'Show this company'
    click_on 'Vehicles'
    click_on 'New Vehicle'
    expect(current_path).to eq '/companies/1/vehicles/new'
    fill_in 'License plate', with: ''
    fill_in 'Brand', with: 'Ford'
    fill_in 'Model', with: 'F4000'
    fill_in 'Year', with: '2009'
    fill_in 'Load capacity', with: '3000'
    click_on 'Submit'

    expect(page).to have_content 'Vehicle not created'
    expect(page).to have_content "License plate can't be blank"
  end

  it 'should not create a new vehicle with duplicated license plate' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    company = Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')
    Vehicle.create!(license_plate: 'EJK2098', brand: 'Volkswagen', model: 'Cargo', year: '2022', load_capacity: '2000', company: company)

    visit('companies/1/vehicles')
    click_on 'New Vehicle'
    expect(current_path).to eq '/companies/1/vehicles/new'

    fill_in 'License plate', with: 'EJK2098'
    fill_in 'Brand', with: 'Ford'
    fill_in 'Model', with: 'F4000'
    fill_in 'Year', with: '2009'
    fill_in 'Load capacity', with: '3000'
    click_on 'Submit'

    expect(page).to have_content 'Vehicle not created'
    expect(page).to have_content 'License plate has already been taken'
  end

end
