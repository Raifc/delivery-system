require 'rails_helper'

describe 'Admin visits companies page' do
  it 'and see Companies header' do
    visit('companies')
    expect(page).to have_content('Companies')
  end

  it 'and see created companies' do
    first_address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    first_email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: first_address, email_domain: first_email_domain, status: 'Active')

    second_address = Address.new(full_address: '230, 2nd street', city: 'Chicago', state: 'IL')
    second_email_domain = EmailDomain.new(domain: '@chicago_shipping.com')
    Company.create!(corporate_name: 'Chicago', trading_name: 'Chicago Cargo', registration_number: '245798000155', address: second_address, email_domain: second_email_domain, status: 'Active')

    visit('companies')
    expect(page).to have_content 'Beta'
    expect(page).to have_content 'Alfa'
    expect(page).to have_content 'Registration Number 1234567'
    expect(page).to have_content 'Status Active'
    expect(page).to have_content 'Corporate Name Chicago'
    expect(page).to have_content 'Trading Name Chicago Cargo'
    expect(page).to have_content 'Registration Number 245798000155'
    expect(page).to have_content 'Status Active'
  end

  it 'and there are no companies created' do
    visit('companies')
    expect(page).to have_content('No companies yet!')
  end

end