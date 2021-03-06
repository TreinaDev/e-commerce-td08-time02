class ProductsController < ApplicationController
  before_action :set_product, only: %i[show activate deactivate update_cashback]
  before_action :authenticate_admin!, only: %i[new create activate deactivate]

  def index
    @categories = Category.active
    Product.active.each do |product|
      product.inactive! if product.prices.empty? || product.prices.last.end_date < Time.zone.today
    end
    @products = admin_signed_in? ? Product.all : Product.active
  end

  def new
    @product = Product.new
    @start_date = Time.zone.today
    @product.prices.build
    @categories = Category.all
    @cashbacks = Cashback.where('end_date >= :today', today: Date.today)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: t('product_creation_succeeded')
    else
      @cashbacks = Cashback.where('end_date >= :today', today: Date.today)
      @categories = Category.active
      flash.now[:alert] = t('product_creation_failed')
      render :new
    end
  end

  def search
    @categories = Category.active
    @products = admin_signed_in? ? Product.all : Product.active
    @products = @products.where('name LIKE :query OR description LIKE :query OR sku LIKE :query',
                                query: "%#{params[:query]}%")
    render :index
  end

  def show
    @product.inactive! if @product.prices.empty? || @product.prices.last.end_date < Time.zone.today
    unless @product.active? || admin_signed_in?
      return redirect_to root_path, notice: t('inactive_or_inexistent_product')
    end

    @rating_average = Review.where('product_id = ?', @product).average(:rating).to_f
    @reviews = Review.where(product_id: @product).order('created_at DESC')

    set_cashback
    set_new_price
  end

  def filter
    @category = Category.find(params[:format])
    @products = @category.all_products(admin_signed_in?)
    @categories = Category.active

    render :index
  end

  def activate
    if @product.prices.last.end_date - Time.zone.today >= 90
      @product.active!
      return redirect_to @product, notice: t('product_activation_succeeded')
    end

    set_new_price
    @reviews = Review.where(product_id: @product).order('created_at DESC')
    flash.now[:alert] = t('product_activation_failed')
    render :show
  end

  def deactivate
    @product.inactive!
    redirect_to @product, notice: t('product_deactivation_succeeded')
  end

  def update_cashback
    @product.update(cashback_id: params[:product][:cashback_id])

    redirect_to @product, notice: t('cashback_updated')
  end

  private

  def product_params
    params.require(:product).permit(:name, :brand, :category_id, :description, :sku, :width, :height,
                                    :depth, :weight, :shipping_price, :fragile, :manual, :cashback_id,
                                    photos: [], prices_attributes: %i[id admin_id start_date end_date value])
  end

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: t('inactive_or_inexistent_product')
  end

  def set_cashback
    return unless @product.cashback

    @cashbacks = Cashback.all
    @cashback = @product.cashback
    @cashback_value = @product.current_price.rubies_value *  @cashback.percentual/100.0
  end

  def set_new_price
    @price = Price.new
    @start_date = @product.prices.empty? ? @start_date = Time.zone.today : @product.prices.last.end_date + 1
  end
end
