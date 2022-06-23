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
      flash.now[:notice] = t('promotion_not_created')
      render :new
    end
  end

  def index
    @promotions = Promotion.all
  end

  def show; end
  
  private

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

  def promotion_params
    params.require(:promotion).permit(:name, :discount_percentual, :discount_max,
                                      :usage_limit, :start_date, :end_date)
  end
end
