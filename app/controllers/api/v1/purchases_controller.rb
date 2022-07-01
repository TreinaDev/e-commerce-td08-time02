class Api::V1::PurchasesController < ActionController::API
  def update_status
    purchase = Purchase.find_by(code: params[:code])

    purchase.update(params.permit(:status, :message))
  end
end
