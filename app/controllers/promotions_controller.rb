class PromotionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_promotion, only: %i[show]

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    @promotion.admin = current_admin
    if @promotion.save
      redirect_to @promotion, notice: t('promotion_created')
    else
      flash.now[:alert] = t('promotion_not_created')
      render :new
    end
  end

  def index
    @promotions = Promotion.all
  end

  def show
    unless @promotion
      return redirect_to root_path, notice: t('inexistent_promotion')
    end
  end
  
  private

  def set_promotion
    @promotion = Promotion.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    @promotion = nil
  end

  def promotion_params
    params.require(:promotion).permit(:name, :discount_percentual, :discount_max,
                                      :usage_limit, :start_date, :end_date)
  end
end
