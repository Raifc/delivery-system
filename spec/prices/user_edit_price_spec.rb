require 'rails_helper'

describe 'User creates prices' do
  it 'should edit a price successfully' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')
    Price.create!(min_volume: 1, max_volume: 3, min_weight: 1, max_weight: 10, km_value: 1)

    visit('companies/1/prices')
    click_on 'Show this price'
    click_on 'Edit this price'
    expect(current_path).to eq '/companies/1/prices/1/edit'
    fill_in 'Min volume', with: '10'
    fill_in 'Max volume', with: '30'
    fill_in 'Min weight', with: '3'
    fill_in 'Max weight', with: '10'
    fill_in 'Km value', with: '3'
    click_on 'Submit'

    expect(current_path).to eq '/companies/1/prices'

    expect(page).to have_content 'Price successfully updated'
    expect(page).to have_content 'Minimum Volume 10.0'
    expect(page).to have_content 'Maximum Volume 30.0'
    expect(page).to have_content 'Minimum Weight 3.0'
    expect(page).to have_content 'Maximum Weight 10.0'
    expect(page).to have_content 'Km Value 3.0'
  end

  it 'should not update price with empty maximum weight' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')

    visit('companies/1/prices')
    click_on 'New Price'
    expect(current_path).to eq '/companies/1/prices/new'
    fill_in 'Min volume', with: '10'
    fill_in 'Max volume', with: '30'
    fill_in 'Min weight', with: '3'
    fill_in 'Max weight', with: '10'
    fill_in 'Km value', with: ''
    click_on 'Submit'

    expect(page).to have_content 'Price not updated'
    expect(page).to have_content "Max weight can't be blank"
  end

end
