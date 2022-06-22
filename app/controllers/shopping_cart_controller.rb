class ShoppingCartController < ApplicationController
  before_action :authenticate_client!

  def index
    @product_items = ProductItem.where(client_id: current_client.id)
    @total = get_total(current_client)
    @total_frete = get_total_frete(current_client)
    @total_products = get_total_produtos(current_client)
  end

  def get_total(current_client)
    (get_total_product(current_client) + get_total_frete(current_client)).to_f
  end

  def get_total_product(current_client)
    total_value = 0
    current_client.product_items.each do |product_item|
      total_value += get_product_total_price(product_item)
    end
    total_value.to_f
  end

  def get_total_frete(current_client)
    total_value = 0
    current_client.product_items.each do |product_item|
      total_value += get_product_shipping_price(product_item)
    end
    total_value.to_f
  end

  def get_product_total_price(product_item)
    product_item.product.current_price*product_item.quantity
  end

  def get_product_shipping_price(product_item)
    product_item.product.shipping_price*product_item.quantity
  end
end
