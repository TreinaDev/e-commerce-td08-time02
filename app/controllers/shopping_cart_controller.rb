class ShoppingCartController < ApplicationController
  before_action :authenticate_client!

  def index
    @product_items = current_client.product_items
    @item_ids = @product_items.map(&:id)
    @total_shipping = current_client.purchase_shipping_value
    @total_products = current_client.purchase_value
    @total = @total_shipping + @total_products
    @cashback = current_client.purchase_cashback_value
  end
end
