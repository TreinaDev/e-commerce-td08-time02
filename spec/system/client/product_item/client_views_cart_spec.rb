require 'rails_helper'

describe 'Cliente vê carrinho' do
  it 'e vê produtos adicionados ao carrinho' do
    create :exchange_rate, value: 2.00
    client = create :client
    first_product = create :product, name: 'Mouse', shipping_price: 10.00
    create :price, product: first_product, value: 10.00
    second_product = create :product, category: first_product.category, name: 'Monitor 8k',
                                      shipping_price: 20.00
    create :price, product: second_product, value: 20.00

    login_as client, scope: :client
    visit product_path(first_product)
    click_on 'Adicionar ao carrinho'
    visit product_path(second_product)
    click_on 'Adicionar ao carrinho'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'

    expect(page).to have_content 'Meu Carrinho'
    within("##{first_product.id}") do
      expect(page).to have_content 'Mouse'
      expect(page).to have_content '1'
      expect(page).to have_content 'Preço Unitário: 5,00 rubis'
      expect(page).to have_content 'Frete: 5,00 rubis'
      expect(page).to have_content 'Subtotal: 5,00 rubis'
    end
    within("##{second_product.id}") do
      expect(page).to have_content 'Monitor 8k'
      expect(page).to have_content '2'
      expect(page).to have_content 'Preço Unitário: 10,00 rubis'
      expect(page).to have_content 'Frete: 20,00 rubis'
      expect(page).to have_content 'Subtotal: 20,00 rubis'
    end
    expect(page).to have_content 'Total frete: 25,00 rubis'
    expect(page).to have_content 'Total produtos: 25,00 rubis'
    expect(page).to have_content 'Total: 50,00 rubis'
  end

  it 'e não há produtos duplicados' do
    create :exchange_rate
    client = create :client
    product = create :product, name: 'Mouse'
    create :price, product: product

    login_as client, scope: :client
    visit product_path(product)
    click_on 'Adicionar ao carrinho'
    click_on 'Adicionar ao carrinho'
    click_on 'Carrinho'

    within("##{product.id}") do
      expect(page).to have_content 'Mouse'
      expect(page).to have_content '2'
    end
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
    create :exchange_rate
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
