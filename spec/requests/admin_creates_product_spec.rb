require 'rails_helper'

describe 'Administrador cria produto' do
  it 'com sucesso' do
    admin = create :admin
    product = { name: 'Monitor 8k', brand: 'LG', sku: 'MON8K-64792',
                description: 'Monitor de alta qualidade', width: '100', height: '50',
                weight: '12', shipping_price: '23', depth: '12', fragile: true }

    login_as admin
    post products_path, params: { product: }

    expect(response).to redirect_to product_path(Product.last.id)
    expect(Product.count).to eq 1
  end

  it 'com dados incompletos' do
    admin = create :admin
    product = { name: '', brand: 'LG', sku: 'MON8K-64792',
                description: 'Monitor de alta qualidade', width: '100', height: '50',
                weight: '12', shipping_price: '23', depth: '12', fragile: true }

    login_as admin, scope: :admin
    post products_path, params: { product: }

    expect(Product.count).to eq(0)
  end
end
