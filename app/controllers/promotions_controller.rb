class PromotionsController < ApplicationController
  before_action :set_promotion, only: %i[show]

  def index
    @promotions = Promotion.all
  end

  def show; end
  
  private

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end
