require 'rails_helper'

describe 'Administrador se autentica' do
  it 'com sucesso' do
    Admin.create!(email: 'admin@mercadores.com.br', password: 'password', name: 'João', status: :approved)

    visit root_path
    click_on 'Entrar como administrador'
    fill_in 'E-mail', with: 'admin@mercadores.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Autenticação efetuada com sucesso.'
    expect(page).to have_content 'João (admin@mercadores.com.br)'
    expect(page).not_to have_link 'Entrar como administrador'
  end

  it 'com dados incompletos' do
    visit(new_admin_session_path)
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    click_on('Entrar')

    expect(page).to have_content('E-mail ou senha inválidos')
    expect(page).to have_current_path new_admin_session_path
    expect(page).not_to have_content 'Autenticação efetuada com sucesso.'
    expect(page).to have_link 'Entrar como administrador'
  end

  it 'com dados incorretos' do
    Admin.create!(email: 'admin@mercadores.com.br', password: 'password', name: 'João', status: :approved)

    visit(new_admin_session_path)
    fill_in 'E-mail', with: 'adminmercadores.com.br'
    fill_in 'Senha', with: 'senha'
    click_on('Entrar')

    expect(page).to have_content('E-mail ou senha inválidos')
    expect(page).to have_current_path new_admin_session_path
    expect(page).not_to have_content 'Autenticação efetuada com sucesso.'
    expect(page).to have_link 'Entrar como administrador'
  end

  it 'e seu cadastro não foi aprovado por outro Administrador' do
    Admin.create!(email: 'admin@mercadores.com.br', password: 'password', name: 'João', status: :pending)

    visit(new_admin_session_path)
    fill_in 'E-mail', with: 'admin@mercadores.com.br'
    fill_in 'Senha', with: 'password'
    click_on('Entrar')

    expect(page).to have_current_path new_admin_session_path
    expect(page).to have_content 'Seu cadastro ainda não foi aprovado por outro administrador.'
  end
end
