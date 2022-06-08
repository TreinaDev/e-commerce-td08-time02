require 'rails_helper'

describe 'Administrador se autentica' do
  it 'com sucesso' do
    Admin.create!(email: 'admin@mercadores.com.br', password: 'password', name: 'João', status: :approved)

    visit root_path
    click_on 'Login como administrador'
    fill_in 'E-mail', with: 'admin@mercadores.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Log in'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_content 'João (admin@mercadores.com.br)'
    expect(page).not_to have_link 'Login como administrador'
  end
end
