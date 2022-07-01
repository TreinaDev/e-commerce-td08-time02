require 'rails_helper'

describe 'Cliente confirma compra' do
  it 'com sucesso' do
    client = create :client, has_wallet: true, code: '510.309.910-14'
    create :exchange_rate, value: 2.0
    cashback = create :cashback, percentual: 10
    first_product = create :product, shipping_price: 10.00, cashback: cashback
    create :price, product: first_product, value: 20.00
    second_product = create :product, category: first_product.category, shipping_price: 20.00
    create :price, product: second_product, value: 10.00
    first_item = create :product_item, client: client, product: first_product, quantity: 1
    second_item = create :product_item, client: client, product: second_product, quantity: 1
    purchase_data_sent = { transaction: { order: 1, registered_number: '510.309.910-14',
                                          value: 3000, cashback: 100 } }.to_json
    purchase_status_data = { transaction: { order: 1, registered_number: '510.309.910-14',
                                            status: 'accepted', message: nil } }.to_json
    purchase_response = instance_double Faraday::Response, status: :created, body: purchase_status_data
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/transactions', purchase_data_sent,
                                          content_type: 'application/json').and_return(purchase_response)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Confirmar Compra'
    client.reload

    expect(page).to have_current_path root_path
    expect(Purchase.count).to eq 1
    expect(Purchase.last.cashback_value).to eq 1.0
    expect(Purchase.last).to be_approved
    expect(Purchase.last.product_items).to eq [first_item, second_item]
    expect(client.product_items).to be_empty
    expect(page).to have_content 'Compra realizada!'
  end

  it 'e não possui saldo suficiente' do
    create :exchange_rate, value: 2.0
    client = create :client, has_wallet: true, code: '510.309.910-14'
    product = create :product, shipping_price: 10.00
    create :price, product: product, value: 20.00
    item = create :product_item, client: client, product: product, quantity: 1
    purchase_data_sent = { transaction: { order: 1, registered_number: '510.309.910-14',
                                          value: 1500, cashback: 0 } }.to_json
    purchase_status_data = { transaction: { order: 1, registered_number: '510.309.910-14',
                                            status: 'pending', message: nil } }.to_json
    purchase_response = instance_double Faraday::Response, status: :created, body: purchase_status_data
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/transactions', purchase_data_sent,
                                          content_type: 'application/json').and_return(purchase_response)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Confirmar Compra'
    client.reload

    expect(page).to have_content 'Compra pendente de aprovação'
    expect(page).to have_current_path root_path
    expect(Purchase.count).to eq 1
    expect(Purchase.last).to be_pending
    expect(Purchase.last.product_items).to eq [item]
    expect(client.product_items).to be_empty
  end

  it 'e a API de pagamentos está fora do ar' do
    create :exchange_rate, value: 2.0
    client = create :client, has_wallet: true, code: '510.309.910-14'
    first_product = create :product, shipping_price: 10.00
    create :price, product: first_product, value: 20.00
    item = create :product_item, client: client, product: first_product, quantity: 1
    allow(Faraday).to receive(:post).and_raise(Faraday::ConnectionFailed)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Confirmar Compra'

    expect(page).to have_current_path shopping_cart_path
    expect(page).to have_content 'Falha na confirmação. Tente novamente mais tarde'
    expect(Purchase.count).to eq 0
    expect(client.product_items).to include item
  end

  it 'e os itens são removidos do carrinho' do
    create :exchange_rate, value: 2.0
    client = create :client, has_wallet: true, code: '510.309.910-14'
    product = create :product, shipping_price: 10.00
    create :price, product: product, value: 20.00
    create :product_item, client: client, product: product, quantity: 1
    purchase_data_sent = { transaction: { order: 1, registered_number: '510.309.910-14',
                                          value: 1500, cashback: 0 } }.to_json
    purchase_status_data = { transaction: { order: 1, registered_number: '510.309.910-14',
                                            status: 'accepted', message: nil } }.to_json
    purchase_response = instance_double Faraday::Response, status: :created, body: purchase_status_data
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/transactions', purchase_data_sent,
                                          content_type: 'application/json').and_return(purchase_response)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Confirmar Compra'
    visit shopping_cart_path

    expect(page).to have_content 'Não há produtos no carrinho'
  end

  it 'e cria uma carteira em Pagamentos' do
    client = create :client, email: 'cliente@cliente.com', code: '510.309.910-14', has_wallet: false
    create :exchange_rate, value: 2.0
    product = create :product, shipping_price: 10.00
    create :price, product: product, value: 20.00
    create :product_item, client: client, product: product, quantity: 1
    client_data = { client_wallet: { email: 'cliente@cliente.com', registered_number: '510.309.910-14' } }
    wallet_response = instance_double Faraday::Response, status: 201, body: ''
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/client_wallets',
                                          client_data).and_return wallet_response
    purchase_data_sent = { transaction: { order: 1, registered_number: '510.309.910-14',
                                          value: 1500, cashback: 0 } }.to_json
    purchase_status_data = { transaction: { order: 1, registered_number: '510.309.910-14',
                                            status: 'pending', message: nil } }.to_json
    purchase_response = instance_double Faraday::Response, status: :created, body: purchase_status_data
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/transactions', purchase_data_sent,
                                          content_type: 'application/json').and_return(purchase_response)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Confirmar Compra'
    client.reload

    expect(client.has_wallet).to be true
    expect(Purchase.count).to eq 1
    expect(Purchase.last).to be_pending
    expect(page).to have_content 'Compra pendente de aprovação'
  end
end
