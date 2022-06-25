class CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_category, only: %i[show activate deactivate]

  def index
    @categories = Category.where(category: nil)
  end

  def show
    @supercategory = @category.category if @category.category
  end

  def new
    @category = Category.new
    @categories = Category.all
    @promotions = Promotion.where('end_date > :today', today: Date.today)
  end

  def create
    @category = Category.new(category_params)
    @category.admin_id = current_admin.id
    @categories = Category.all
    @promotions = Promotion.where('end_date > :today', today: Date.today)

    if @category.save
      redirect_to categories_path, notice: t('category_created')
    else
      flash.now[:alert] = t('category_not_created')
      render 'new'
    end
  end

  def activate
    @category.active!
    redirect_to @category, notice: t('category_activation_succeeded')
  end

  def deactivate
    @category.disabled!
    redirect_to @category, notice: t('category_deactivation_succeeded')
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :category_id, :promotion_id)
  end
end
