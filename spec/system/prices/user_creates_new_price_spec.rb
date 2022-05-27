require 'rails_helper'

describe 'User creates prices' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should create a new price' do
    visit company_path(user.company)

    click_on 'Prices'
    click_on 'New Price'
    expect(current_path).to eq '/companies/1/prices/new'
    fill_in 'Min volume', with: '10'
    fill_in 'Max volume', with: '30'
    fill_in 'Min weight', with: '3'
    fill_in 'Max weight', with: '10'
    fill_in 'Km value', with: '3'
    click_on 'Submit'

    expect(current_path).to eq '/companies/1/prices'
    within 'table' do
      expect(page).to have_content 'Min Volume'
      expect(page).to have_content '10.0'
      expect(page).to have_content 'Max Volume'
      expect(page).to have_content '30.0'
      expect(page).to have_content 'Min Weight'
      expect(page).to have_content '3.0'
      expect(page).to have_content 'Max Weight'
      expect(page).to have_content '10.0'
      expect(page).to have_content 'Value for km'
      expect(page).to have_content '3.0'
    end
  end

  it 'should not create a new price with empty km value' do
    visit company_path(user.company)

    click_on 'Prices'
    click_on 'New Price'
    expect(current_path).to eq '/companies/1/prices/new'
    fill_in 'Min volume', with: '10'
    fill_in 'Max volume', with: '30'
    fill_in 'Min weight', with: '3'
    fill_in 'Max weight', with: '10'
    fill_in 'Km value', with: ''
    click_on 'Submit'

    expect(page).to have_content 'Price not created'
    expect(page).to have_content "Km value can't be blank"
  end

end
