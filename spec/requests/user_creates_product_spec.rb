require 'rails_helper'

describe 'admin criar produto' do
  it 'e nao é admin' do
    product = {name: 'Monitor 8k', brand: 'LG', sku: 'MON8K-64792',
      description: 'Monitor de auta qualidade', width: '100', height: '50',
      weight: '12', shipping_price: '23', depth: '12', fragile: true}

    post(products_path, params: {product: product})

    expect(response).to redirect_to(new_admin_session_path)
    expect(Product.count).to eq(0)
  end

  it 'com sucesso' do
    user = Admin.create!(name: 'Administrador', email: 'admin@mercadores.com.br', password: 'password', status: 'approved')
    login_as(user)

    product = {name: 'Monitor 8k', brand: 'LG', sku: 'MON8K-64792',
      description: 'Monitor de auta qualidade', width: '100', height: '50',
      weight: '12', shipping_price: '23', depth: '12', fragile: true}

    post(products_path, params: {product: product})

    expect(response).to redirect_to(product_path(Product.last.id))
    expect(Product.count).to eq(1)
  end

  it 'faltando dados' do
    user = Admin.create!(name: 'Administrador', email: 'admin@mercadores.com.br', password: 'password', status: 'approved')
    login_as(user)

    product = {name: '', brand: 'LG', sku: 'MON8K-64792',
      description: 'Monitor de auta qualidade', width: '100', height: '50',
      weight: '12', shipping_price: '23', depth: '12', fragile: true}

    post(products_path, params: {product: product})

    expect(Product.count).to eq(0)
  end
end