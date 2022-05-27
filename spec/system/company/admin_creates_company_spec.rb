require 'rails_helper'

describe 'Admin creates new Company' do
  it 'without login' do
    visit new_company_path
    expect(current_path).to eq new_admin_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  it 'should create a new company' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'New Company'
    expect(current_path).to eq '/companies/new'
    fill_in 'Corporate name', with: 'Rodonaves'
    fill_in 'Trading name', with: 'Ronaves transports'
    fill_in 'Registration number', with: '123334556000123'
    fill_in 'Full address', with: 'Floriano Peixoto, 1000'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'State', with: 'RJ'
    fill_in 'Email domain', with: 'rodonaves.com.br'
    select 'Active', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company successfully created'
    expect(page).to have_content 'Corporate Name Rodonaves'
    expect(page).to have_content 'Trading Name Ronaves transports'
    expect(page).to have_content 'Registration Number 123334556000123'
    expect(page).to have_content 'Status Active'

  end

  it 'should not create a company with empty corporate name' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'New Company'
    expect(current_path).to eq '/companies/new'
    fill_in 'Corporate name', with: ''
    fill_in 'Trading name', with: 'Ronaves transports'
    fill_in 'Registration number', with: '123334556000123'
    fill_in 'Full address', with: 'Floriano Peixoto, 1000'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'State', with: 'RJ'
    fill_in 'Email domain', with: 'rodonaves.com.br'
    select 'Active', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company not created'
    expect(page).to have_content "Corporate name can't be blank"

  end

  it 'should not create a company with duplicated registration number' do
    address = Address.create!(full_address: '100, 1st street', city: 'New York', state: 'New York')
    company = Company.create!(corporate_name: 'Monster Transports', trading_name: 'Monster', registration_number: '1234567', address: address, email_domain: 'alfa.com')

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'New Company'
    expect(current_path).to eq '/companies/new'
    fill_in 'Corporate name', with: 'Rodonaves'
    fill_in 'Trading name', with: 'Ronaves transports'
    fill_in 'Registration number', with: '1234567'
    fill_in 'Full address', with: 'Floriano Peixoto, 1000'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'State', with: 'RJ'
    fill_in 'Email domain', with: 'rodonaves.com.br'
    select 'Active', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company not created'
    expect(page).to have_content 'Registration number has already been taken'

  end

  it 'should not create a company with empty full address informations' do

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'New Company'
    expect(current_path).to eq '/companies/new'
    fill_in 'Corporate name', with: 'Rodonaves'
    fill_in 'Trading name', with: 'Ronaves transports'
    fill_in 'Registration number', with: '1234567'
    fill_in 'Full address', with: ''
    fill_in 'City', with: ''
    fill_in 'State', with: ''
    fill_in 'Email domain', with: 'rodonaves.com.br'
    select 'Active', from: 'Status'
    click_on 'Submit'

    expect(page).to have_content 'Company not created'
    expect(page).to have_content "full address can't be blank"
    expect(page).to have_content "city can't be blank"
    expect(page).to have_content "state can't be blank"
  end

  it 'should not create a company with empty email domain' do

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'New Company'
    expect(current_path).to eq '/companies/new'
    fill_in 'Corporate name', with: 'Rodonaves'
    fill_in 'Trading name', with: 'Ronaves transports'
    fill_in 'Registration number', with: '123334556000123'
    fill_in 'Full address', with: 'Floriano Peixoto, 1000'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'State', with: 'RJ'
    fill_in 'Email domain', with: ''
    select 'Active', from: 'Status'
    click_on 'Submit'


    expect(page).to have_content 'Company not created'
    expect(page).to have_content "Email domain is invalid"
  end

end
