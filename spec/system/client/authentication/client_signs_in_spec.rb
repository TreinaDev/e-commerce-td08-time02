require 'rails_helper'

describe 'Cliente se autentica' do
  it 'com sucesso' do
    cliente = Client.create!(name: 'Nicolas', code: '623.809.720-52', email: 'cliente@email.com', password: 'password')

    visit root_path
    click_on 'Entrar como Cliente'
    fill_in 'E-mail', with: 'cliente@email.com'
    fill_in 'Senha', with: 'password'
    within('.actions') do
      click_on 'Entrar'
    end

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Autenticação efetuada com sucesso.'
    expect(page).to have_content 'Nicolas (cliente@email.com)'
    expect(page).not_to have_link 'Entrar como Cliente'
  end

  it 'com dados incompletos' do
    visit(new_client_session_path)
    fill_in('E-mail', with: '')
    fill_in('Senha', with: '')
    within('.actions') do 
      click_on 'Entrar'
    end

    expect(page).to have_content('E-mail ou senha inválidos')
    expect(page).to have_current_path new_client_session_path
    expect(page).not_to have_content('Autenticação efetuada com sucesso.')
    expect(page).to have_link('Entrar como Cliente')
  end

  it 'com dados incorretos' do
    Client.create!(email: 'cliente@email.com', password: 'password', name: 'Nicolas', code: '623.809.720-52')

    visit(new_client_session_path)
    fill_in 'E-mail', with: 'cliente@email.com'
    fill_in 'Senha', with: 'senhaerrada'
    click_on('Entrar')

    expect(page).to have_content('E-mail ou senha inválidos')
    expect(page).to have_current_path new_client_session_path
    expect(page).not_to have_content 'Autenticação efetuada com sucesso.'
    expect(page).to have_link 'Entrar como Cliente'
  end
end