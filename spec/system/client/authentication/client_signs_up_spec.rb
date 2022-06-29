require 'rails_helper'

describe 'Cliente se cadastra' do
  it 'com sucesso' do
    visit root_path
    find('#menu-desktop').click_on('Entrar como Cliente')
    click_on('Registrar-se')
    fill_in('E-mail', with: 'james@outlook.com')
    fill_in('Senha', with: 'password')
    fill_in('Confirmar senha', with: 'password')
    fill_in('Nome', with: 'James')
    fill_in('CPF/CNPJ', with: '29498318000126')
    click_on('Registrar-se')

    expect(page).to have_current_path root_path
    expect(page).to have_content('Cadastro efetuado com sucesso.')
    expect(page).not_to have_content('Entrar como Cliente')
    expect(page).to have_content('James (james@outlook.com)')
  end

  it 'com dados incompletos' do
    visit(new_client_registration_path)
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    fill_in 'Nome', with: ''
    fill_in 'CPF/CNPJ', with: ''
    click_on('Registrar-se')

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(page).to have_content 'CPF/CNPJ não pode ficar em branco'
    expect(page).to have_current_path client_registration_path
    expect(page).not_to have_content 'Cadastro efetuado com sucesso.'
  end
end
