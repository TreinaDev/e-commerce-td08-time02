class ReviewsController < ApplicationController
  before_action :set_product, only: %i[new create average_raiting]
  before_action :authenticate_client!

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.product_id = @product.id
    @review.client_id = current_client.id

    if @review.save
      redirect_to @product, notice: t('review_created')
    else

      flash.now[:notice] = t('review_not_created')
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
