class ProductItemsController < ApplicationController
  before_action :authenticate_client!
  rescue_from ActiveRecord::ActiveRecordError, with: :return_fail
  def create
    @product = Product.find(params[:product_id])
    @client_id = current_client.id
    unless IncrementItemService.new(@product, @client_id).call
      product_item = @product.product_items.new(client_id: current_client.id)
      product_item.save
    end
    redirect_to @product, notice: "#{@product.name} #{t('added_to_cart')}"
  end

  private

  def return_fail
    redirect_to @product, notice: t('add_to_cart_failed')
  end
end
