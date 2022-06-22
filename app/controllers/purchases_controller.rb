class PurchasesController < ApplicationController
  before_action :set_client

  def create
    items = params[:item_ids].map { |id| ProductItem.find(id) }

    purchase = Purchase.create(client: @client, product_items: items)
    json_data = { code: @client.code, value: purchase.value }.to_json
    response = Faraday.post('http://localhost:4000/api/v1/transactions', json_data,
                            content_type: 'application/json')
    redirect_to root_path, notice: response.body
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end
end
