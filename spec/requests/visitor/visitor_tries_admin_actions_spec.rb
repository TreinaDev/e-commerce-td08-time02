require 'rails_helper'

describe 'Visitante não autenticado' do
  it 'tenta autorizar cadastro pendente' do
    admin = create :admin, status: :pending

    post approve_pending_admin_path(admin)

    expect(response).to redirect_to new_admin_session_path
  end

  it 'tenta criar produto' do
    category = create :category
    product = { name: 'Monitor 8k', brand: 'LG', sku: 'MON8K-64792', category: category,
                description: 'Monitor de alta qualidade', width: 100, height: 50, weight: 12, depth: 12,
                shipping_price: 23, fragile: true }

    post products_path, params: { product: product }

    expect(response).to redirect_to new_admin_session_path
    expect(Product.count).to eq 0
  end

  it 'tenta ativar produto' do
    product = create :product, status: :inactive

    post activate_product_path(product)

    expect(response).to redirect_to new_admin_session_path
    expect(product).to be_inactive
  end

  it 'tenta desativar produto' do
    product = create :product, status: :active

    post deactivate_product_path(product)

    expect(response).to redirect_to new_admin_session_path
    expect(product).to be_active
  end

  it 'tenta visualizar produto inativo' do
    product = create :product, status: :inactive
    create :price, product: product

    get product_path(product)

    expect(response).to redirect_to root_path
  end

  it 'tenta ativar categoria' do
    category = create(:category, status: :disabled)

    post activate_category_path(category.id)
    category.reload

    expect(response).to redirect_to new_admin_session_path
    expect(category).to be_disabled
  end

  it 'tenta desativar categoria' do
    category = create(:category, status: :active)

    post deactivate_category_path(category.id)
    category.reload

    expect(response).to redirect_to new_admin_session_path
    expect(category).to be_active
  end

  it 'tenta fazer avaliação' do
    product = create(:product, name: 'Monitor 8k', status: :active)
    create(:price, product: product, admin: product.category.admin, start_date: Time.zone.today,
                   end_date: 90.days.from_now, value: 1500.00)
    review =  { product: product, rating: 3, comment: 'Muito bom.'}

    post product_reviews_path(product.id), params: { review: review }

    expect(response).to redirect_to new_client_session_path
    expect(Review.count).to eq 0
  end
end
