class PurchasesController < ApplicationController
  before_action :set_client

  def create
    items = params[:item_ids].map { |id| ProductItem.find(id) }
    purchase = Purchase.new(client: @client, product_items: items)
    response_status = SendPurchaseDataService.response_status(purchase)
    if response_status
      purchase.save
      notice = response_status == 'accepted' ? t('purchase_confirmed') : t('purchase_pending')
      return redirect_to root_path, notice: notice
    end
    redirect_to shopping_cart_path, alert: t('purchase_failed')
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end
end
