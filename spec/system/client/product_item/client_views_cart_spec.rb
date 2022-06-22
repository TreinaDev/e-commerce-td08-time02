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
    within("#{first_product.name}") do
    
    end

    expect(page).to have_content 'Meu Carrinho'
    within("#{first_product.name}") do
      expect(page).to have_content 'Monitor 8k'
      expect(page).to have_content '1'
      expect(page).to have_content "Preço Unitário: #{first_product.current_price}"
      expect(page).to have_content "Frete: #{ShippingCartController.get_product_shipping_price(first_product)}"
      expect(page).to have_content "Subtotal: #{ShippingCartController.get_product_total_price(first_product)}"
    end
    within("#{second_product.name}") do
      expect(page).to have_content 'Mouse'
      expect(page).to have_content '2'
      expect(page).to have_content "Preço Unitário: #{second_product.current_price}"
      expect(page).to have_content "Frete: #{ShippingCartController.get_product_shipping_price(second_product)}"
      expect(page).to have_content "Subtotal: #{ShippingCartController.get_product_total_price(second_product)}"
    end
    expect(page).to have_content "Total frete: #{ShippingCartController.get_total_frete(client)}"
    expect(page).to have_content "Total produtos: #{ShippingCartController.get_total_product(client)}"
    expect(page).to have_content "Total: #{ShippingCartController.get_total(client)}"
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
