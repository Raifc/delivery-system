require 'rails_helper'

describe 'Admin edit a Company' do
  it 'successfully' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')

    visit('companies')
    click_on 'Show this company'
    click_on 'Edit this company'
    expect(current_path).to eq '/companies/1/edit'
    fill_in 'Corporate name', with: 'Rodonaves'
    fill_in 'Trading name', with: 'Ronaves transports'
    fill_in 'Registration number', with: '123334556000123'
    fill_in 'Full address', with: 'Floriano Peixoto, 1000'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'State', with: 'RJ'
    fill_in 'Domain', with: '@rodonaves.com.br'
    select 'active', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company successfully updated'
    expect(page).to have_content 'Corporate Name Rodonaves'
    expect(page).to have_content 'Trading Name Ronaves transports'
    expect(page).to have_content 'Registration Number 123334556000123'

  end

  it 'and leaves registration number empty' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')

    visit('companies')
    click_on 'Show this company'
    click_on 'Edit this company'

    fill_in 'Corporate name', with: 'Rodonaves'
    fill_in 'Trading name', with: 'Ronaves transports'
    fill_in 'Registration number', with: ''
    fill_in 'Full address', with: 'Floriano Peixoto, 1000'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'State', with: 'RJ'
    fill_in 'Domain', with: '@rodonaves.com.br'
    select 'active', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company not updated'
    expect(page).to have_content "Registration number can't be blank"

  end

  it 'and leaves registration number empty' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain)

    visit('companies')
    click_on 'Show this company'
    click_on 'Edit this company'

    select 'Inactive', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company successfully updated'
    expect(page).to have_content 'Status Inactive'
  end

end
