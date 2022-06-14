class CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.where(category: nil)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    @category.admin_id = current_admin.id
    @categories = Category.all

    if @category.save
      redirect_to categories_path, notice: t('category_created')
    else
      flash.now[:alert] = t('category_not_created')
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :category_id)
  end
end
