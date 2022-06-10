require 'rails_helper'

describe 'Visitante visita a app' do
  it 'com sucesso' do
    visit root_path

    expect(page).to have_content 'E-Commerce'
  end

  it 'e volta para a tela inicial' do
    visit new_admin_session_path
    find('nav').click_on 'Página Inicial'

    expect(page).to have_current_path root_path
  end
end
