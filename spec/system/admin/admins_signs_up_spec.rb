require 'rails_helper'

describe 'Admin signs up' do
  it 'with wrong email domain' do
    visit root_path
    click_on 'Login - Administrador'
    click_on 'Sign up'
    fill_in 'Email', with: 'admin@wrong.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content 'Email não é válido'
  end

  it 'with valid email domain' do
    visit root_path
    click_on 'Login - Administrador'
    click_on 'Sign up'
    fill_in 'Email', with: 'admin@sistemadefrete.com.br'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content 'Transportadoras'
    expect(page).to have_content 'Admin: admin@sistemadefrete.com.br'
  end

end