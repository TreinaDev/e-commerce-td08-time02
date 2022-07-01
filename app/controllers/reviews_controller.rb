class ReviewsController < ApplicationController
  before_action :set_product, only: %i[new create average_raiting]
  before_action :authenticate_client!

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.product = @product
    @review.client = current_client

    if @review.save
      redirect_to @product, notice: t('review_created')
    else

      flash.now[:alert] = t('review_not_created')
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :product_id, :client_id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
