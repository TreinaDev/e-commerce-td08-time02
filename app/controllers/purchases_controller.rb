class PurchasesController < ApplicationController
  before_action :authenticate_client!

  def create
    purchase = Purchase.new(purchase_params)
    purchase.product_items = current_client.product_items
    purchase.save
    response_status = SendPurchaseDataService.response_status(purchase)
    if response_status
      purchase.approved!
      return redirect_to root_path, notice: t('purchase_confirmed')
    end

    purchase.destroy
    redirect_to shopping_cart_path, alert: t('purchase_failed')
  end

  private

  def purchase_params
    params.permit(:client_id, :value)
  end
end
