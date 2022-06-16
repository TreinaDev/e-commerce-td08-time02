class ShoppingCartController < ApplicationController
  def index
    @product_items = []

    session[:product_item_id].each do |item_id|
      @product_items << ProductItem.find(item_id)
    end
  end
end
