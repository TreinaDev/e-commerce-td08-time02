require 'rails_helper'

describe 'Cliente remove item do carrinho' do
  it 'com sucesso' do
    client = create :client
    product = create(:product, name: 'Mouse', status: :active)
    create(:product_item, client:, product:)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Remover Produto'

    expect(page).not_to have_content 'Mouse'
    expect(page).to have_content 'Produto Removido!'
    expect(ProductItem.count).to eq 0
  end
end
