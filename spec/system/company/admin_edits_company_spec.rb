require 'rails_helper'

describe 'Admin edit a Company' do
  it 'without login' do
    visit new_company_path
    expect(current_path).to eq new_admin_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  it 'successfully' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'M Transports', trading_name: 'Monster Transports', registration_number: '1234567', address: address, email_domain: 'monster.com', status: 'Active')

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

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
    fill_in 'Email domain', with: 'rodonaves.com.br'
    select 'active', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company successfully updated'
    expect(page).to have_content 'Corporate Name Rodonaves'
    expect(page).to have_content 'Trading Name Ronaves transports'
    expect(page).to have_content 'Registration Number 123334556000123'

  end

  it 'should not update without registration number' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'M Transports', trading_name: 'Monster Transports', registration_number: '1234567', address: address, email_domain: 'monster.com', status: 'Active')

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Show this company'
    click_on 'Edit this company'
    expect(current_path).to eq '/companies/1/edit'
    fill_in 'Corporate name', with: 'Rodonaves'
    fill_in 'Trading name', with: 'Ronaves transports'
    fill_in 'Registration number', with: ''
    fill_in 'Full address', with: 'Floriano Peixoto, 1000'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'State', with: 'RJ'
    fill_in 'Email domain', with: 'rodonaves.com.br'
    select 'active', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company not updated'
    expect(page).to have_content "Registration number can't be blank"

  end

  it 'should not update without corporate name' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'M Transports', trading_name: 'Monster Transports', registration_number: '1234567', address: address, email_domain: 'monster.com', status: 'Active')

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Show this company'
    click_on 'Edit this company'
    expect(current_path).to eq '/companies/1/edit'
    fill_in 'Corporate name', with: ''
    fill_in 'Trading name', with: 'Ronaves transports'
    fill_in 'Registration number', with: '1234567'
    fill_in 'Full address', with: 'Floriano Peixoto, 1000'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'State', with: 'RJ'
    fill_in 'Email domain', with: 'rodonaves.com.br'
    select 'active', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company not updated'
    expect(page).to have_content "Corporate name can't be blank"
  end

end
