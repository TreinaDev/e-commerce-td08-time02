class Api::V1::ClientsController < ActionController::API
  def update_balance
    client = Client.find_by(code: params[:registered_number])
    client.update(balance: params[:balance].to_d / 100)
  end
end
