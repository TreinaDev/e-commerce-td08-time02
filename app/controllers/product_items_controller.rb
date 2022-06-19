class ProductItemsController < ApplicationController
  before_action :authenticate_client!
  rescue_from ActiveRecord::ActiveRecordError, with: :return_fail

  def create
    @product = Product.find(params[:product_id])
    client = current_client

    unless IncrementItemService.new(@product, client).edit_quantity
      ProductItem.create(client: client, product: @product)
    end

    redirect_to @product, notice: "#{@product.name} #{t('added_to_cart')}"
  end

  def destroy
    product_item = ProductItem.find(params[:id])
    product_item.destroy

    redirect_to shopping_cart_path, notice: t('product_removed')
  end

  def sum_quantity
    product_item = ProductItem.find(params[:id])
    product_item.quantity += 1
    product_item.save

    redirect_to shopping_cart_path
  end

  def dec_quantity
    product_item = ProductItem.find(params[:id])

    product_item.quantity -= 1
    product_item.save

    redirect_to shopping_cart_path
  end

  private

  def return_fail
    redirect_to @product, notice: t('add_to_cart_failed')
  end
end
