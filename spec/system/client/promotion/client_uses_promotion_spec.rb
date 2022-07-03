require 'rails_helper'

describe 'Cliente usa cupom promocional' do
  it 'com sucesso' do
    client = create :client
    create :exchange_rate, value: 2.0
    allow(SecureRandom).to receive(:alphanumeric).and_return 'ABCD1234'
    promotion = create :promotion, discount_percentual: 10
    category = create :category, promotion: promotion
    product = create :product, category: category, shipping_price: 10.00
    create :price, product: product, value: 20.00
    create :product_item, client: client, product: product, quantity: 2

    login_as client, scope: :client
    visit shopping_cart_path
    fill_in 'Cupom promocional', with: 'ABCD1234'
    click_on 'Aplicar cupom'
    promotion.reload

    expect(promotion.used_times).to eq 1
    within("##{product.id}") do
      expect(page).to have_content 'Preço Unitário: $10,00'
      expect(page).to have_content 'Frete: $10,00'
      expect(page).to have_content 'Desconto: $2,00'
      expect(page).to have_content 'Subtotal: $18,00'
    end
    expect(page).to have_content 'Total frete: $10,00'
    expect(page).to have_content 'Total produtos: $18,00'
    expect(page).to have_content 'Total: $28,00'
  end

  # it 'inválido' do

  # end
end
