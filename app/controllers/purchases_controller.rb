class PurchasesController < ApplicationController
  before_action :set_client

  def create
    items = params[:item_ids].map { |id| ProductItem.find(id) }
    purchase = Purchase.new(client: @client, product_items: items)
    response_status = SendPurchaseDataService.response_status(purchase)
    return unless response_status

    purchase.save
    notice = response_status == 'accepted' ? 'Compra Recebida!' : 'Compra pendente de aprovação'
    redirect_to root_path, notice: notice
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end
end
