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
    @product_items = current_client.product_items
    @item_ids = @product_items.map(&:id)
    @total_shipping = current_client.purchase_shipping_value
    @cashback = current_client.purchase_cashback_value
    @promotion = Promotion.find_by(coupon: params[:coupon])
    if @promotion.is_valid_status == 'Vigente'
      @total_products = current_client.purchase_value(@promotion.discount_percentual)
      @promotion.used_times += 1
      @promotion.save
    end
    @total = @total_shipping + @total_products
    render :index
  end
end
