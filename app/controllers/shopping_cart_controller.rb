class ShoppingCartController < ApplicationController
  before_action :authenticate_client!

  def index
    @product_items = ProductItem.where(client_id: current_client.id)
    @item_ids = @product_items.map(&:id)
  end
end
