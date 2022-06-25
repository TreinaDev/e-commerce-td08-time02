require 'rails_helper'

describe 'Cliente confirma compra' do
  it 'com sucesso' do
    create :exchange_rate, value: 2.0
    client = create :client, code: '510.309.910-14'
    first_product = create :product, shipping_price: 10.00
    create :price, product: first_product, value: 20.00
    second_product = create :product, category: first_product.category, shipping_price: 20.00
    create :price, product: second_product, value: 10.00
    create :product_item, client: client, product: first_product, quantity: 1
    create :product_item, client: client, product: second_product, quantity: 1
    purchase_data_sent = { transaction: { order: 1, registered_number: '510.309.910-14',
                                          value: 3000, cashback: 0 } }.to_json
    purchase_status_data = { transaction: { order: 1, registered_number: '510.309.910-14',
                                            status: 'accepted', message: nil } }.to_json
    purchase_response = instance_double Faraday::Response, status: :created, body: purchase_status_data
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/transactions', purchase_data_sent,
                                          content_type: 'application/json').and_return(purchase_response)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Confirmar Compra'

    expect(page).to have_current_path root_path
    expect(Purchase.count).to eq 1
    expect(Purchase.last).to be_approved
    expect(page).to have_content 'Compra realizada!'
  end

  # it 'e não possui saldo suficiente' do
  #   client = create :client, code: '510.309.910-14'
  #   first_product = create :product, shipping_price: 15.00
  #   create :price, admin: first_product.category.admin, product: first_product, value: 50.00
  #   create :product_item, client: client, product: first_product, quantity: 1
  #   client_data = { client_wallet: { registered_number: client.code } }
  #   balance_data = { client_wallet: { balance: 60.00, bonus_balance: 4.00 } }.to_json
  #   fake_balance = instance_double Faraday::Response, status: :ok, body: balance_data
  #   allow(Faraday).to receive(:get).with(
  #     'http://localhost:4000/api/v1/client_wallet/balance', client_data
  #   ).and_return(fake_balance)
  #   purchase_status_data = { transaction: { status: 'pending' } }.to_json
  #   purchase_response = instance_double Faraday::Response, status: :created, body: purchase_status_data
  #   purchase_data_sent = { transaction: { registered_number: client.code, value: '65.0' } }.to_json
  #   allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/transactions', purchase_data_sent,
  #                                         content_type: 'application/json').and_return(purchase_response)

  #   login_as client, scope: :client
  #   visit shopping_cart_path
  #   click_on 'Confirmar Compra'

  #   expect(page).to have_current_path root_path
  #   expect(Purchase.count).to eq 1
  #   expect(Purchase.last).to be_pending
  #   expect(page).to have_content 'Compra pendente de aprovação'
  # end

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
