require 'rails_helper'

describe 'Cliente vê carrinho' do
  it 'e vê produtos adicionados ao carrinho' do
    client = create :client
    admin = create(:admin)
    category = create(:category, admin:)
    create(:product, name: 'Monitor 8k', status: :active, category:)

    login_as client, scope: :client
    visit products_path
    click_on 'Monitor 8k'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'

    expect(page).to have_content 'Meu Carrinho'
    expect(page).to have_content 'Monitor 8k'
    expect(page).to have_content 'Quantidade: 1'
  end
end
