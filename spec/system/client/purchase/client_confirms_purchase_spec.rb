require 'rails_helper'

describe 'Cliente confirma compra' do
  it 'com sucesso' do
    client = create :client, code: '510.309.910-14'
    first_product = create :product, shipping_price: 15.00
    create :price, admin: first_product.category.admin, product: first_product, value: 50.00
    second_product = create :product, category: first_product.category, shipping_price: 20.00
    create :price, admin: second_product.category.admin, product: second_product, value: 35.89
    create :product_item, client: client, product: first_product, quantity: 1
    create :product_item, client: client, product: second_product, quantity: 1
    response_data = { transaction: { status: 'accepted' } }.to_json
    fake_response = instance_double Faraday::Response, status: :created, body: response_data
    json_data = { transaction: { registered_number: client.code, value: '120.89' } }.to_json
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/transactions', json_data,
                                          content_type: 'application/json').and_return(fake_response)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Confirmar Compra'

    expect(page).to have_current_path root_path
    expect(Purchase.count).to eq 1
    expect(page).to have_content 'Compra realizada!'
  end

  it 'e houve um erro na API' do
    client = create :client, code: '510.309.910-14'
    first_product = create :product, shipping_price: 15.00
    create :price, admin: first_product.category.admin, product: first_product, value: 50.00
    create :product_item, client: client, product: first_product, quantity: 1
    response_data = { error: 'Internal server error' }.to_json
    fake_response = instance_double Faraday::Response, status: :internal_server_error, body: response_data
    json_data = { transaction: { registered_number: client.code, value: '65.0' } }.to_json
    allow(Faraday).to receive(:post).with(
      'http://localhost:4000/api/v1/transactions', json_data, content_type: 'application/json'
    ).and_return(fake_response)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Confirmar Compra'

    expect(page).to have_current_path shopping_cart_path
    expect(page).to have_content 'Falha na confirmação. Tente novamente mais tarde'
    expect(Purchase.count).to eq 0
  end
end
