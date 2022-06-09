require 'rails_helper'

describe 'Administrador se cadastra' do
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar como administrador'
    click_on 'Registrar-se'
    fill_in 'E-mail', with: 'admin@mercadores.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirmar senha', with: 'password'
    fill_in 'Nome', with: 'João'
    click_on 'Registrar-se'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Cadastro efetuado com sucesso. Esperando por aprovação por outro Administrador.'
    expect(page).to have_link 'Entrar como administrador'
    expect(page).not_to have_content 'João (admin@mercadores.com.br)'
  end
end
