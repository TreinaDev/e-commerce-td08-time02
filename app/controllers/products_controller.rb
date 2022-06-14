class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :authenticate_admin!, only: %i[new create]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Produto criado com sucesso'
    else
      @categories = Category.all
      flash.now[:notice] = "Falha ao cadastrar produto"
      render :new
    end
  end

  def show; end

  private

  def product_params
    params.require(:product).permit(:name, :brand, :category_id, :description, :sku, :width, :height, :depth, :weight,
                                    :shipping_price, :fragile, :manual, photos: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
