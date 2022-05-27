require 'rails_helper'

describe 'Admin visits companies page' do

  it 'without login' do
    visit new_company_path
    expect(current_path).to eq new_admin_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  it 'and see Companies header' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin
    visit('companies')
    expect(page).to have_content('Companies')
  end

  it 'and see created companies' do
    first_address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'NY')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: first_address, email_domain: 'betatransp.com', status: 'Active')

    second_address = Address.new(full_address: '230, 2nd street', city: 'Chicago', state: 'IL')
    Company.create!(corporate_name: 'Chicago', trading_name: 'Chicago Cargo', registration_number: '245798000155', address: second_address, email_domain: 'chicagotransp.com', status: 'Active')

    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    within 'table' do
      expect(page).to have_content 'Corporate Name'
      expect(page).to have_content 'Beta'
      expect(page).to have_content 'Trading Name'
      expect(page).to have_content 'Alfa'
      expect(page).to have_content 'Registration Number'
      expect(page).to have_content '1234567'
      expect(page).to have_content 'Status'
      expect(page).to have_content 'Active'
      expect(page).to have_content 'Corporate Name'
      expect(page).to have_content 'Chicago'
      expect(page).to have_content 'Trading Name'
      expect(page).to have_content 'Chicago Cargo'
      expect(page).to have_content 'Registration Number'
      expect(page).to have_content '245798000155'
      expect(page).to have_content 'Status'
      expect(page).to have_content 'Active'
    end
  end

  it 'and there are no companies created' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    expect(page).to have_content('No companies yet!')
  end

end