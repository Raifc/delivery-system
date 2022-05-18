require 'rails_helper'

describe 'User creates delivery times' do
  it 'should create a new delivery time' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')

    visit('companies/1/delivery_times')
    click_on 'New Delivery Time'
    expect(current_path).to eq '/companies/1/delivery_times/new'
    fill_in 'Min distance', with: '30'
    fill_in 'Max distance', with: '100'
    fill_in 'Business days', with: '3'
    click_on 'Submit'

    expect(current_path).to eq '/companies/1/delivery_times'
    expect(page).to have_content 'Delivery Time successfully created'
    expect(page).to have_content 'Minimum Distance 30'
    expect(page).to have_content 'Maximum Distance 100'
    expect(page).to have_content 'Business Days 3'
  end

  it 'should not create a new delivery time with empty business days' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')

    visit('companies/1/delivery_times')
    click_on 'New Delivery Time'
    expect(current_path).to eq '/companies/1/delivery_times/new'
    fill_in 'Min distance', with: '30'
    fill_in 'Max distance', with: '100'
    fill_in 'Business days', with: ''
    click_on 'Submit'

    expect(page).to have_content 'Delivery Time not created'
    expect(page).to have_content "Business days can't be blank"
  end

end
