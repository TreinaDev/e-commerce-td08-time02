require 'rails_helper'

describe 'Administrador sai do sistema' do
  it 'com sucesso' do
    admin = create :admin, name: 'João', email: 'admin@mercadores.com.br'

    login_as admin, scope: :admin
    visit root_path
    click_on 'Sair'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Saída efetuada com sucesso.'
    expect(page).not_to have_content 'João (admin@mercadores.com.br)'
    expect(page).to have_link 'Entrar como Administrador'
  end
end
