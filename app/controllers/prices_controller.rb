class PricesController < ApplicationController
  def create
    @product = Product.find(price_params[:product_id])
    @product.prices.create(price_params)
    redirect_to @product, notice: t('price_registered')
  end

  private

  def price_params
    params.require(:price).permit(%i[product_id admin_id start_date end_date value])
  end
end
