require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it { is_expected.to belong_to(:client) }

  it { is_expected.to have_many(:product_items) }

  it { is_expected.to define_enum_for(:status).with_values(pending: 0, approved: 5, rejected: 10) }

  it '#calculate_value' do
    first_product = create :product, shipping_price: 15.00
    create :price, admin: first_product.category.admin, product: first_product, value: 50.00
    second_product = create :product, category: first_product.category, shipping_price: 20.00
    create :price, admin: second_product.category.admin, product: second_product, value: 35.00
    first_item = create :product_item, product: first_product, quantity: 2
    second_item = create :product_item, client: first_item.client, product: second_product, quantity: 1
    purchase = described_class.new(client: first_item.client, product_items: [first_item, second_item])

    purchase.save

    expect(purchase.value).to eq 170.00
  end
end
