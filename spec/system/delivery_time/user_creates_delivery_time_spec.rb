require 'rails_helper'

describe 'User creates delivery times' do

  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should create a new delivery time' do
    visit company_path(user.company)

    click_on 'Delivery Times'
    click_on 'New Delivery Time'
    expect(current_path).to eq '/companies/1/delivery_times/new'
    fill_in 'Min distance', with: '30'
    fill_in 'Max distance', with: '100'
    fill_in 'Business days', with: '3'
    click_on 'Submit'

    expect(current_path).to eq '/companies/1/delivery_times'
    expect(page).to have_content 'Delivery Time successfully created'
    within 'table' do
      expect(page).to have_content 'Min Distance'
      expect(page).to have_content '30'
      expect(page).to have_content 'Max Distance'
      expect(page).to have_content '100'
      expect(page).to have_content 'Delivery Time - Business Days'
      expect(page).to have_content '3'
    end
  end

  it 'should not create a new delivery time with empty business days' do
    visit company_path(user.company)

    click_on 'Delivery Time'
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

