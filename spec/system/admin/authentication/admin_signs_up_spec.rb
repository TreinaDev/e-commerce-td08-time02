require 'rails_helper'

describe 'Administrador se cadastra' do
  it 'com sucesso' do
    visit root_path
    find('#menu-desktop').click_on 'Entrar como Administrador'
    click_on 'Registrar-se'
    fill_in 'E-mail', with: 'admin@mercadores.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirmar senha', with: 'password'
    fill_in 'Nome', with: 'João'
    click_on 'Registrar-se'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Cadastro efetuado com sucesso. Esperando por aprovação por outro Administrador.'
    expect(page).to have_link 'Entrar como Administrador'
    expect(page).not_to have_content 'João (admin@mercadores.com.br)'
  end

  it 'com e-mail de domínio incorreto' do
    visit new_admin_registration_path
    fill_in 'E-mail', with: 'admin@mercadoras.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirmar senha', with: 'password'
    fill_in 'Nome', with: 'João'
    click_on 'Registrar-se'

    expect(page).to have_current_path admin_registration_path
    expect(page).not_to have_content 'Cadastro efetuado com sucesso. Esperando por aprovação por outro Administrador.'
    expect(page).to have_content 'E-mail não é válido'
  end

  it 'com dados incompletos' do
    visit(new_admin_registration_path)
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    fill_in 'Nome', with: ''
    click_on('Registrar')

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(page).to have_current_path admin_registration_path
    expect(page).not_to have_content 'Cadastro efetuado com sucesso. Esperando por aprovação por outro Administrador.'
  end
end
