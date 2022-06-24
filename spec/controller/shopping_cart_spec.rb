require 'rails_helper'

RSpec.describe ShoppingCartController, type: :controller do
  describe '.get_total' do
    it 'calcula o preço de todos os itens do carrinho' do
      first_client = create :client
      first_product = create(:product, name: 'Monitor 8k', shipping_price: 50)
      create(:price, product: first_product, admin: first_product.category.admin, value: 99)
      second_product = create(:product, name: 'Mouse', category: first_product.category, shipping_price: 60)
      create(:price, product: second_product, admin: second_product.category.admin, value: 500)
      create(:product_item, client: first_client, product: second_product, quantity: 2)
      create(:product_item, client: first_client, product: first_product)

      result = ShoppingCartController.new.get_total(first_client)

      expect(result).to eq 1269
    end
  end
end