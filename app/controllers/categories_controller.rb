class CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    @category.admin_id = current_admin.id
    @categories = Category.all

    if @category.save
      redirect_to root_path, notice: f('category_created')
    else
      flash.now[:alert] = f('category_not_created')
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :category_id)
  end
end
