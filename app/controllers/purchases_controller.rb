class PurchasesController < ApplicationController
  before_action :authenticate_client!
  before_action :set_client

  def create
    items = params[:item_ids].map { |id| ProductItem.find(id) }
    purchase = Purchase.new(client: @client, product_items: items)
    response_status = SendPurchaseDataService.response_status(purchase)
    if response_status
      define_purchase_status(purchase)
      return redirect_to root_path, notice: @notice
    end
    redirect_to shopping_cart_path, alert: t('purchase_failed')
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def define_purchase_status(purchase)
    purchase.approved!
    @notice = t('purchase_confirmed')
  end
end
