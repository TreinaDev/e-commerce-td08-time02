class PurchasesController < ApplicationController
  before_action :authenticate_client!

  def index
    @purchases = Purchase.where(client: current_client)
  end

  def create
    purchase = Purchase.new(purchase_params)
    purchase.product_items = current_client.product_items
    purchase.save
    response = PurchaseDataService.send(purchase)
    if response&.status == :created
      PurchaseDataService.change_purchase_status(purchase, response)
      return redirect_to root_path, notice: PurchaseDataService.status_notice(purchase)
    end

    purchase.destroy
    redirect_to shopping_cart_path, alert: t('purchase_failed')
  end

  private

  def purchase_params
    params.permit(:client_id, :value)
  end
end
