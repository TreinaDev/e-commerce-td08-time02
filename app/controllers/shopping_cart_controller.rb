class ShoppingCartController < ApplicationController
  before_action :authenticate_client!

  def index
    client = current_client.id
    @product_items = ProductItem.where(client_id: client)
  end
end
