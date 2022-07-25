class StockProductsController < ApplicationController
  def index
    @products = StockProduct.all
  end

  def change
    @products = StockProduct.all
    stock = StockProduct.find(params[:id])
    stock.quantity = params[:value]
    stock.save
    render :index
  end
end