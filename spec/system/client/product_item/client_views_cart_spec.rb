require 'rails_helper'

describe 'Cliente vê carrinho' do
  it 'e vê produtos adicionados ao carrinho' do
    client = create :client
    first_product = create(:product, name: 'Mouse')
    create(:price, product: first_product, admin: first_product.category.admin)
    second_product = create(:product, category: first_product.category, name: 'Monitor 8k')
    create(:price, product: second_product, admin: second_product.category.admin)

    login_as client, scope: :client
    visit product_path(first_product)
    click_on 'Adicionar ao carrinho'
    visit product_path(second_product)
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'

    expect(page).to have_content 'Meu Carrinho'
    expect(page).to have_content 'Monitor 8k'
    expect(page).to have_content '1'
    expect(page).to have_content 'Mouse'
  end

  it 'e não há produtos duplicados' do
    client = create :client
    product = create(:product, name: 'Mouse')
    create(:price, product: product, admin: product.category.admin)

    login_as client, scope: :client
    visit product_path(product)
    click_on 'Adicionar ao carrinho'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'

    expect(page).to have_content 'Mouse'
    expect(page).to have_content '2'
    expect(ProductItem.count).to eq 1
  end

  it 'e não há produtos no carrinho' do
    client = create :client

    login_as client, scope: :client
    visit root_path
    click_on 'Carrinho'

    expect(page).to have_content 'Não há produtos no carrinho'
  end

  it 'e pode ver detalhes do produto adicionado' do
    client = create :client
    first_product = create(:product, name: 'Monitor 8k')
    create(:price, product: first_product, admin: first_product.category.admin)
    second_product = create(:product, name: 'Mouse', category: first_product.category)
    create(:price, product: second_product, admin: second_product.category.admin)
    create(:product_item, client: client, product: second_product)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Mouse'

    expect(page).to have_current_path product_path(second_product)
    expect(page).to have_content 'Mouse'
  end
end
