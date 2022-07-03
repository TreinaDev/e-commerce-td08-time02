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

  def apply_coupon
    @promotion = Promotion.find_by(coupon: params[:coupon])
    @promotion.update(used_times: @promotion.used_times + 1) if @promotion.is_valid_status == 'Vigente'
    @product_items = current_client.product_items
    @item_ids = @product_items.map(&:id)
    @total_shipping = current_client.purchase_shipping_value
    @total_products = current_client.purchase_value
    @cashback = current_client.purchase_cashback_value
    @total = @total_shipping + @total_products
    render :index
  end
end
