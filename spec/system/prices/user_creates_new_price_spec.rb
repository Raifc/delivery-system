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

    click_on 'Preços'
    click_on 'Novo preço'
    expect(current_path).to eq '/companies/1/prices/new'
    fill_in 'Volume mínimo', with: '10'
    fill_in 'Volume máximo', with: '30'
    fill_in 'Peso mínimo', with: '3'
    fill_in 'Peso máximo', with: '10'
    fill_in 'Valor por km', with: '3'
    click_on 'Criar Preço'

    expect(current_path).to eq '/companies/1/prices'
    within 'table' do
      expect(page).to have_content 'Volume mínimo'
      expect(page).to have_content '10.0'
      expect(page).to have_content 'Volume máximo'
      expect(page).to have_content '30.0'
      expect(page).to have_content 'Peso mínimo'
      expect(page).to have_content '3.0'
      expect(page).to have_content 'Peso máximo'
      expect(page).to have_content '10.0'
      expect(page).to have_content 'Valor por km'
      expect(page).to have_content '3.0'
    end
  end

  it 'should not create a new price with empty km value' do
    visit company_path(user.company)

    click_on 'Preços'
    click_on 'Novo preço'
    expect(current_path).to eq '/companies/1/prices/new'
    fill_in 'Volume mínimo', with: '10'
    fill_in 'Volume máximo', with: '30'
    fill_in 'Peso mínimo', with: '3'
    fill_in 'Peso máximo', with: '10'
    fill_in 'Valor por km', with: ''
    click_on 'Criar Preço'

    expect(page).to have_content "Falha ao criar preço"
    expect(page).to have_content "Valor por km não pode ficar em branco"
  end


  it 'should not create a new price with min volume bigger than max volume' do
    visit company_path(user.company)

    click_on 'Preços'
    click_on 'Novo preço'
    expect(current_path).to eq '/companies/1/prices/new'
    fill_in 'Volume mínimo', with: '100'
    fill_in 'Volume máximo', with: '5'
    fill_in 'Peso mínimo', with: '3'
    fill_in 'Peso máximo', with: '10'
    fill_in 'Valor por km', with: '120'
    click_on 'Criar Preço'

    expect(page).to have_content "Falha ao criar preço"
    expect(page).to have_content "Volume máximo deve ser maior que o volume mínimo"
  end

  it 'should not create a new price with min weight bigger than max weight' do
    visit company_path(user.company)

    click_on 'Preços'
    click_on 'Novo preço'
    expect(current_path).to eq '/companies/1/prices/new'
    fill_in 'Volume mínimo', with: '10'
    fill_in 'Volume máximo', with: '100'
    fill_in 'Peso mínimo', with: '900'
    fill_in 'Peso máximo', with: '200'
    fill_in 'Valor por km', with: '120'
    click_on 'Criar Preço'

    expect(page).to have_content "Falha ao criar preço"
    expect(page).to have_content "Peso máximo deve ser maior que o peso mínimo"
  end

  it 'should not create a new price with negative max volume' do
    visit company_path(user.company)

    click_on 'Preços'
    click_on 'Novo preço'
    expect(current_path).to eq '/companies/1/prices/new'
    fill_in 'Volume mínimo', with: '10'
    fill_in 'Volume máximo', with: '-1'
    fill_in 'Peso mínimo', with: '900'
    fill_in 'Peso máximo', with: '200'
    fill_in 'Valor por km', with: '120'
    click_on 'Criar Preço'

    expect(page).to have_content "Falha ao criar preço"
    expect(page).to have_content "Volume máximo deve ser positivo"
  end

  it 'should not create a new price with negative min weight' do
    visit company_path(user.company)

    click_on 'Preços'
    click_on 'Novo preço'
    expect(current_path).to eq '/companies/1/prices/new'
    fill_in 'Volume mínimo', with: '10'
    fill_in 'Volume máximo', with: '20'
    fill_in 'Peso mínimo', with: '-1'
    fill_in 'Peso máximo', with: '200'
    fill_in 'Valor por km', with: '120'
    click_on 'Criar Preço'

    expect(page).to have_content "Falha ao criar preço"
    expect(page).to have_content "Peso mínimo deve ser positivo"
  end

end
