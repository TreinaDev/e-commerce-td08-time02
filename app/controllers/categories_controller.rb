class CategoriesController < ApplicationController

  def index
    @categories = Category.all
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
      redirect_to categories_path, notice: 'Categoria Cadastrada com Sucesso!'
    else
      flash.now[:alert] = 'Não foi possível cadastrar a categoria'
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :category_id)
  end
end
