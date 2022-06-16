class ProductItemsController < ApplicationController
  rescue_from ActiveRecord::ActiveRecordError, with: :return_fail
  def create
    @product = Product.find(params[:product_id])
    product_item = @product.product_items.new
    product_item.save
    session[:product_item_id] = [] if session[:product_item_id].nil?

    session[:product_item_id] << product_item.id
    redirect_to @product, notice: "#{@product.name} #{t('added_to_cart')}"
  end

  private

  def return_fail
    redirect_to @product, notice: t('add_to_cart_failed')
  end
end
