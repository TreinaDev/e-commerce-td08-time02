class ProductsController < ApplicationController
  before_action :set_product, only: %i[show activate deactivate]
  before_action :authenticate_admin!, only: %i[new create activate deactivate]

  def index
    @products = admin_signed_in? ? Product.all : Product.active
  end

  def new
    @product = Product.new
    @start_date = Time.zone.today
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

  def show
    if @product.inactive? && admin_signed_in? == false
      redirect_to root_path, notice: t('product_visualization_failed')
    else
      @price = Price.new
      @start_date = @product.prices.last.end_date + 1
    end
  end

  def activate
    if @product.prices.last.end_date - Time.zone.today >= 90
      @product.active!
      redirect_to @product, notice: t('product_activation_succeeded')
    else
      @price = Price.new
      @start_date = @product.prices.last.end_date + 1
      flash.now[:notice] = t('product_activation_failed')
      render :show
    end
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
