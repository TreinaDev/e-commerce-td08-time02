class PurchasesController < ApplicationController
  before_action :authenticate_client!, only: :create
  before_action :authenticate_admin!, only: :search
  before_action :authenticate_client_or_admin, only: :index

  def index
    @client = current_client if client_signed_in?
    @purchases = Purchase.where(client: @client)
  end

  def create
    purchase = Purchase.create(purchase_params)
    response = PurchaseDataService.send(purchase)
    if response&.status == :created
      PurchaseDataService.change_purchase_status(purchase, response)
      return redirect_to root_path, notice: PurchaseDataService.status_notice(purchase)
    end

    purchase.destroy
    redirect_to shopping_cart_path, alert: t('purchase_failed')
  end

  def search
    @client = Client.find_by('name LIKE ? OR code = ?', "%#{params[:query]}%", params[:query])
    @purchases = Purchase.where(client: @client)

    @message = 'Cliente não encontrado.' unless @client

    render :index
  end

  private

  def purchase_params
    params.permit(:client_id, :value, :cashback_value).merge(product_items: current_client.product_items)
  end

  def authenticate_client_or_admin
    authenticate_client! unless admin_signed_in?
  end
end
