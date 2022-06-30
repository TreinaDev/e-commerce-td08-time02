require 'rails_helper'

describe 'Visitante não autenticado' do
  it 'deve se autenticar para acessar o carrinho' do
    visit root_path
    click_on 'Carrinho'

    expect(page).to have_current_path new_client_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'adiciona um item ao carrinho' do
    product = create(:product, name: 'Monitor 8k', status: :active)
    create(:price, product: product, admin: product.category.admin)

    visit root_path
    click_on 'Monitor 8k'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_current_path new_client_session_path
  end

  it 'visita a lista de compras realizadas' do
    visit purchases_path

    expect(page).to have_current_path new_client_session_path
  end
end
