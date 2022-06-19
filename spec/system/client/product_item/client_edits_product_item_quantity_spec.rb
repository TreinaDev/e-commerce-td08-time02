require 'rails_helper'

describe 'Cliente edita' do
  it 'aumentando quantidade do item' do
    client = create :client
    admin = create(:admin)
    category = create(:category, admin:)
    product = create(:product, name: 'Mouse', status: :active, category:)
    create(:product_item, client:, product:)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on '+'

    item = ProductItem.last
    expect(item.quantity).to eq 2
  end

  it 'diminuindo quantidade do item' do
    client = create :client
    admin = create(:admin)
    category = create(:category, admin:)
    product = create(:product, name: 'Mouse', status: :active, category:)
    create(:product_item, quantity: 2, client:, product:)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on '-'

    item = ProductItem.last
    expect(item.quantity).to eq 1
  end

  it 'e botão diminuir some quando quantidade for 1' do
    client = create :client
    admin = create(:admin)
    category = create(:category, admin:)
    product = create(:product, name: 'Mouse', status: :active, category:)
    create(:product_item, client:, product:)

    login_as client, scope: :client
    visit shopping_cart_path

    expect(page).not_to have_button '-'
  end
end
