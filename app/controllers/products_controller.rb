class ProductsController < ApplicationController
  before_action :set_product, only: %i[show activate deactivate]
  before_action :authenticate_admin!, only: %i[new create activate deactivate]

  def index
    @products = admin_signed_in? ? Product.all : Product.active
  end

  def new
    @product = Product.new
    @start_date = @product.prices.empty? ? Time.zone.today : @product.prices.last.start_date + 1
    @product.prices.build
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: t('product_creation_succeeded')
    else
      @categories = Category.all
      flash.now[:notice] = t('product_creation_failed')
      render :new
    end
  end

  def show; end

  def activate
    @product.active!

    redirect_to @product, notice: t('product_activation_succeeded')
  end

  def deactivate
    @product.inactive!

    redirect_to @product, notice: t('product_deactivation_succeded')
  end

  private

  def product_params
    params.require(:product).permit(:name, :brand, :category_id, :description, :sku, :width, :height,
                                    :depth, :weight, :shipping_price, :fragile, :manual,
                                    photos: [], prices_attributes: %i[id admin_id start_date end_date value])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
