require 'rails_helper'

describe 'User edits prices - ' do
  let!(:company) {
    @address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    Company.create!(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: @address, email_domain: 'alfa.com')
  }
  let!(:user) { User.create!(email: 'user@alfa.com', password: '123456') }

  before(:each) do
    login_as user, scope: :user
  end

  it 'should edit a price successfully' do
    Price.create!(min_volume: 1, max_volume: 3, min_weight: 1, max_weight: 10, km_value: 1, company: company)
    visit company_path(user.company)

    click_on 'Prices'
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

  it 'should not update price with empty maximum weight' do
    Price.create!(min_volume: 1, max_volume: 3, min_weight: 1, max_weight: 10, km_value: 1, company: company)

    visit company_path(user.company)
    click_on 'Prices'
    click_on 'Show this price'
    click_on 'Edit this price'
    expect(current_path).to eq '/companies/1/prices/1/edit'

    fill_in 'Min volume', with: '10'
    fill_in 'Max volume', with: '30'
    fill_in 'Min weight', with: '3'
    fill_in 'Max weight', with: ''
    fill_in 'Km value', with: '10'
    click_on 'Submit'

    expect(page).to have_content 'Price not updated'
    expect(page).to have_content "Max weight can't be blank"
  end

end
