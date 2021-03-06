class PricesController < ApplicationController
  def create
    @product = Product.find(price_params[:product_id])
    @price = Price.new(price_params)
    return redirect_to @product, notice: t('price_registered') if @price.save
    
    @reviews = Review.where(product_id: @product).order('created_at DESC')
    flash.now[:alert] = t('price_registration_failed')
    render 'products/show'
  end

  private

  def price_params
    params.require(:price).permit(%i[product_id admin_id start_date end_date value])
  end
end
