class ShoppingCartController < ApplicationController
  before_action :authenticate_client!

  def index
    @product_items = ProductItem.where(client_id: current_client.id)
    @item_ids = @product_items.map(&:id)
    @total = get_total(current_client)
    @total_shipping = get_total_shipping(current_client)
    @total_products = get_total_product(current_client)
  end

  def get_total(current_client)
    (get_total_product(current_client) + get_total_shipping(current_client)).to_f
  end

  def get_total_product(current_client)
    total_value = 0
    current_client.product_items.each do |product_item|
      total_value += product_item.define_product_total_price
    end
    total_value.to_f
  end

  def get_total_shipping(current_client)
    total_value = 0
    current_client.product_items.each do |product_item|
      total_value += product_item.define_product_shipping_price
    end
    total_value.to_f
  end
end
