require 'rails_helper'

RSpec.describe ShoppingCartController, type: :controller do
  describe '.get_total' do
    it 'calcula o preço de todos os itens do carrinho' do
      create :exchange_rate, value: 2.0
      first_client = create :client
      first_product = create(:product, name: 'Monitor 8k', shipping_price: 10.00)
      create(:price, product: first_product, admin: first_product.category.admin, value: 10.00)
      second_product = create(:product, name: 'Mouse', category: first_product.category, shipping_price: 20.00)
      create(:price, product: second_product, admin: second_product.category.admin, value: 20.00)
      create(:product_item, client: first_client, product: first_product)
      create(:product_item, client: first_client, product: second_product, quantity: 2)

      result = described_class.new.get_total(first_client)

      expect(result).to eq 50.00
    end
  end
end
