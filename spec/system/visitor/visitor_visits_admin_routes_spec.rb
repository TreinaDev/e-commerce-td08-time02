require 'rails_helper'

describe 'Visitante não autenticado tenta acessar' do
  it 'a tela de cadastros de administradores pendentes' do
    visit pending_admins_path

    expect(page).to have_current_path new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'a tela de cadastro de nova categoria' do
    visit new_category_path

    expect(page).to have_current_path new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'a tela de detalhes de uma categoria' do
    category = create(:category, admin: create(:admin))

    visit category_path(category)

    expect(page).to have_current_path new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'a tela de cadastro de novo produto' do
    visit new_product_path

    expect(page).to have_current_path new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'a tela de listagem de promoções' do
    visit promotions_path

    expect(page).to have_current_path new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'a tela de detalhes de promoção' do
    promotion = create :promotion
    visit promotion_path(promotion)

    expect(page).to have_current_path new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'a busca de compras dos clientes' do
    create :client, name: 'Marquinhos'

    visit search_purchases_path(query: 'Marquinhos')

    expect(page).to have_current_path new_admin_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end
end
