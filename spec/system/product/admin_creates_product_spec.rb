require 'rails_helper'

describe 'Admin creates new product' do
  it 'without login' do
    visit new_company_path
    expect(current_path).to eq new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'should create a new product' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin
    visit('companies')

    click_on 'Produtos'
    click_on 'Novo Produto'
    expect(current_path).to eq '/products/new'

    fill_in 'Código', with: 'SKU201324'
    fill_in 'Altura', with: '2'
    fill_in 'Largura', with: '5'
    fill_in 'Profundidade', with: '8'
    fill_in 'Peso', with: '500'
    click_on 'Criar Produto'

    expect(page).to have_content 'Produto criado com sucesso'
    within 'table' do
      expect(page).to have_content 'Código'
      expect(page).to have_content 'SKU201324'
      expect(page).to have_content 'Altura'
      expect(page).to have_content '2.0 cm'
      expect(page).to have_content 'Largura'
      expect(page).to have_content '5.0 cm'
      expect(page).to have_content 'Profundidade'
      expect(page).to have_content '8.0 cm'
      expect(page).to have_content 'Peso'
      expect(page).to have_content '500.0 g'
    end
  end

  it 'should not create a new product with empty code' do
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin
    visit('companies')
    click_on 'Produtos'
    click_on 'Novo Produto'
    expect(current_path).to eq '/products/new'

    fill_in 'Código', with: ''
    fill_in 'Altura', with: '2'
    fill_in 'Largura', with: '5'
    fill_in 'Profundidade', with: '8'
    fill_in 'Peso', with: '500'
    click_on 'Criar Produto'

    expect(page).to have_content 'Falha ao criar produto'
    expect(page).to have_content 'Código não pode ficar em branco'
  end

end
