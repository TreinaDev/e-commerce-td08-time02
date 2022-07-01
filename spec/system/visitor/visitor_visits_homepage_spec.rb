require 'rails_helper'

describe 'Visitante visita a app' do
  it 'com sucesso' do
    visit root_path

    expect(page).to have_content 'E-Commerce'
  end

  it 'e não encontra links restritos a administradores' do
    visit root_path

    expect(page).not_to have_link 'Categorias'
    expect(page).not_to have_link 'Promoções'
    expect(page).not_to have_link 'Cadastros Pendentes'
  end

  it 'e não encontra links restritos a clientes' do
    visit root_path

    expect(page).not_to have_link 'Compras'
  end

  it 'e volta para a tela inicial' do
    visit new_admin_session_path
    find('#menu-desktop').click_on 'Página Inicial'

    expect(page).to have_current_path root_path
  end
end
