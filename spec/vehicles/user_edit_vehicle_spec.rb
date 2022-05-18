require 'rails_helper'

describe 'User edits a vehicle' do
  it 'should edit a vehicle successfully' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    company = Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')
    Vehicle.create!(license_plate: 'EJK2098', brand: 'Volkswagen', model: 'Cargo', year: '2022', load_capacity: '2000', company: company)

    visit('companies/1/vehicles')
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
    expect(page).to have_content 'License Plate APB2202'
    expect(page).to have_content 'Brand Dodge'
    expect(page).to have_content 'Model Ram'
    expect(page).to have_content 'Year 2020'
    expect(page).to have_content 'Load Capacity 4000'
  end

  it 'should not update vehicle with an empty license plate' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    company = Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')
    Vehicle.create!(license_plate: 'EJK2098', brand: 'Volkswagen', model: 'Cargo', year: '2022', load_capacity: '2000', company: company)

    visit('companies/1/vehicles')
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

  it 'should not update vehicle with a duplicated license plate' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    company = Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')
    Vehicle.create!(license_plate: 'EJG5498', brand: 'GM', model: 'S10', year: '2010', load_capacity: '600', company: company)

    visit('companies/1/vehicles')
    click_on 'Show this vehicle'
    click_on 'Edit this vehicle'
    expect(current_path).to eq '/companies/1/vehicles/1/edit'

    fill_in 'License plate', with: 'EJK2098'
    fill_in 'Brand', with: 'Dodge'
    fill_in 'Model', with: 'Ram'
    fill_in 'Year', with: '2020'
    fill_in 'Load capacity', with: '4000'
    click_on 'Submit'

    expect(page).to have_content 'Vehicle not updated'
    expect(page).to have_content 'License plate has already been taken'
  end

end
