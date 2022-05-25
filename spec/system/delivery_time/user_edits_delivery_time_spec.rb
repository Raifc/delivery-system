require 'rails_helper'

describe 'User edits delivery time - ' do
  it 'should update delivery time' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')
    DeliveryTime.create!(min_distance: '30', max_distance: '50', business_days: '4', company: company)

    visit('companies')
    click_on 'Show this company'
    click_on 'Delivery Time'
    click_on 'Show this delivery time'
    click_on 'Edit this delivery time'
    expect(current_path).to eq '/companies/1/delivery_times/1/edit'
    fill_in 'Min distance', with: '5'
    fill_in 'Max distance', with: '50'
    fill_in 'Business days', with: '2'
    click_on 'Submit'

    expect(page).to have_content 'Delivery time successfully updated'
    within 'table' do
      expect(page).to have_content 'Min Distance'
      expect(page).to have_content '5'
      expect(page).to have_content 'Max Distance'
      expect(page).to have_content '50'
      expect(page).to have_content 'Delivery Time - Business Days'
      expect(page).to have_content '2'
    end
  end

  it 'should update delivery time with empty maximum distance' do
    address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
    email_domain = EmailDomain.new(domain: 'alfa@alfa.com')
    company = Company.new(corporate_name: 'Beta', trading_name: 'Alfa', registration_number: '1234567', address: address, email_domain: email_domain, status: 'Active')
    DeliveryTime.create!(min_distance: '30', max_distance: '50', business_days: '4', company: company)

    visit('companies')
    click_on 'Show this company'
    click_on 'Delivery Time'
    click_on 'Show this delivery time'
    click_on 'Edit this delivery time'
    expect(current_path).to eq '/companies/1/delivery_times/1/edit'
    fill_in 'Min distance', with: '5'
    fill_in 'Max distance', with: ''
    fill_in 'Business days', with: '2'
    click_on 'Submit'

    expect(page).to have_content 'Delivery time not updated'
    expect(page).to have_content "Max distance can't be blank"
  end

end
