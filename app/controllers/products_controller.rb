class ProductsController < ApplicationController
  before_action :set_product, only: %i[show activate deactivate]
  before_action :authenticate_admin!, only: %i[new create activate deactivate]

  def index
    @products = Product.all
    @categories = Category.where('status = 0')
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

  def search
    @query = params[:query]
    @products = Product.where("name LIKE :query OR description LIKE :query OR sku LIKE :query",
                              query: "%#{@query}%")

    render :index
  end

  def show
    unless @product && (@product.active? || admin_signed_in?)
      return redirect_to root_path, notice: t('inactive_or_inexistent_product')
    end

    set_new_price
  end

  def filter
    @category = Category.find(params[:format])
    @products = @category.all_products
    @categories = Category.all
    
    render :index
  end
  
  def activate
    if @product.prices.last.end_date - Time.zone.today >= 90
      @product.active!
      return redirect_to @product, notice: t('product_activation_succeeded')
    end

    set_new_price
    flash.now[:notice] = t('product_activation_failed')
    render :show
  end

  def deactivate
    @product.inactive!
    redirect_to @product, notice: t('product_deactivation_succeeded')
  end
  
  private

  def product_params
    params.require(:product).permit(:name, :brand, :category_id, :description, :sku, :width, :height,
                                    :depth, :weight, :shipping_price, :fragile, :manual,
                                    photos: [], prices_attributes: %i[id admin_id start_date end_date value])
  end

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @product = nil
  end

  def set_new_price
    @price = Price.new
    @start_date = @product.prices.last.end_date + 1
  end
end
