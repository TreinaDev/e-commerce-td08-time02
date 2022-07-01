require 'rails_helper'

describe 'Cliente visualiza detalhes de pedido feito' do
  it 'com sucesso' do
    client = create :client
    create :exchange_rate, value: 2.0
    first_product = create :product, name: 'Monitor 8k', shipping_price: 10.00
    create :price, product: first_product, value: 20.00
    second_product = create :product, name: 'Celular i12', shipping_price: 20.00
    create :price, product: second_product, value: 40.00
    first_purchase = create :purchase, client: client, status: :approved, value: 45.00
    create :product_item, purchase: first_purchase, product: first_product, quantity: 1
    create :product_item, purchase: first_purchase, product: second_product, quantity: 1
    
    login_as client, scope: :client
    visit purchase_path(first_purchase)

    expect(page).to have_content 'Status: Pendente'
    expect(page).to have_content '1 x Monitor 8k'
    expect(page).to have_content '1 x Celular i12'
    expect(page).to have_content 'Total: $180,00'
  end
end