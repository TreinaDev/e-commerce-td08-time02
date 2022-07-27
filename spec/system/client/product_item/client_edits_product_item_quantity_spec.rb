require 'rails_helper'

describe 'Cliente edita' do
  it 'aumentando quantidade do item' do
    create :exchange_rate
    client = create :client
    product = create :product
    StockProduct.destroy_all
    create :stock_product, product: product, quantity: 10
    create(:price, product:)
    create(:product_item, product: product, client: client)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on '+'
    product.reload

    item = ProductItem.last
    expect(item.quantity).to eq 2
    expect(product.stock_product.quantity).to eq 9
  end

  it 'diminuindo quantidade do item' do
    create :exchange_rate
    client = create :client
    product = create :product
    StockProduct.destroy_all
    create :stock_product, product: product, quantity: 10
    create(:price, product:)
    create(:product_item, product: product, client: client, quantity: 2)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on '-'
    product.reload

    item = ProductItem.last
    expect(item.quantity).to eq 1
    expect(product.stock_product.quantity).to eq 11
  end

  it 'e botão diminuir some quando quantidade for 1' do
    create :exchange_rate
    client = create :client
    product = create :product
    create(:price, product:)
    create(:product_item, product: product, client: client)

    login_as client, scope: :client
    visit shopping_cart_path

    expect(page).not_to have_button '-'
  end
end
