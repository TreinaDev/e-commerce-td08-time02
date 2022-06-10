require 'rails_helper'

describe 'usuario tenta criar produto' do
  it 'e nao é admin' do
    product = {name: 'Monitor 8k', brand: 'LG', sku: 'MON8K-64792',
      description: 'Monitor de auta qualidade', width: '100', height: '50',
      weight: '12', shipping_price: '23', depth: '12', fragile: true}

    post(products_path, params: {product: product})

    expect(response).to redirect_to(new_admin_session_path)
  end
end