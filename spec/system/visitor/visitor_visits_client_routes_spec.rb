require 'rails_helper'

describe 'Visitante não autenticado' do
  it 'deve se autenticar para acessar o carrinho' do
    visit root_path
    click_on 'Carrinho'

    expect(page).to have_current_path new_client_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end
end
