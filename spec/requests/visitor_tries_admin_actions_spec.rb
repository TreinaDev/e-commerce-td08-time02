require 'rails_helper'

describe 'Visitante não autenticado' do
  it 'tenta autorizar cadastro pendente' do
    admin = create :admin, status: :pending

    post approve_pending_admin_path(admin.id)

    expect(response).to redirect_to new_admin_session_path
  end

  it 'tenta criar produto' do
    admin = create :admin
    category = create(:category, admin:)
    product = { name: 'Monitor 8k', brand: 'LG', sku: 'MON8K-64792', category_id: category.id,
                description: 'Monitor de auta qualidade', width: 100, height: 50,
                weight: 12, shipping_price: 23, depth: 12, fragile: true }

    post products_path, params: { product: }

    expect(response).to redirect_to new_admin_session_path
    expect(Product.count).to eq 0
  end
end
