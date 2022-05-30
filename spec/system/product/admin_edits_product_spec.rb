require 'rails_helper'

describe 'Admin edits a product' do

  it 'should edit a product' do
    Product.create!(code: 'AXD4580', height: '1.0', width: '1.0', depth: '1.0', weight: '1.0')
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Produtos'
    click_on 'Ver'
    click_on 'Editar'
    expect(current_path).to eq '/products/1/edit'

    fill_in 'Código', with: 'SKU201324'
    fill_in 'Altura', with: '2'
    fill_in 'Largura', with: '5'
    fill_in 'Profundidade', with: '8'
    fill_in 'Peso', with: '500'
    click_on 'Atualizar Produto'

    expect(page).to have_content 'Produto atualizado com sucesso'
    expect(page).to have_content 'Código: SKU201324'
    expect(page).to have_content 'Altura: 2.0 cm'
    expect(page).to have_content 'Largura: 5.0 cm'
    expect(page).to have_content 'Profundidade: 8.0 cm'
    expect(page).to have_content 'Peso: 500.0 g'

  end

  it 'should not update product with empty code' do
    Product.create!(code: 'AXD4580', height: '1.0', width: '1.0', depth: '1.0', weight: '1.0')
    admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')
    login_as admin, scope: :admin

    visit('companies')
    click_on 'Produtos'
    click_on 'Ver'
    click_on 'Editar'
    expect(current_path).to eq '/products/1/edit'

    fill_in 'Código', with: ''
    fill_in 'Altura', with: '2'
    fill_in 'Largura', with: '5'
    fill_in 'Profundidade', with: '8'
    fill_in 'Peso', with: '500'
    click_on 'Atualizar Produto'

    expect(page).to have_content 'Falha ao atualizar produto'
    expect(page).to have_content 'Código não pode ficar em branco'

  end

end
