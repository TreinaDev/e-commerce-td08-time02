class Api::V1::ClientsController < ActionController::API
  before_action :check_params

  def update_balance
    client = Client.find_by(code: params[:registered_number])
    return render status: :not_found, plain: I18n.t('undefined_code') unless client

    client.update(balance: params[:balance].to_d / 100)
    render status: :created, plain: I18n.t('balance_updated')
  end

  private

  def check_params
    body = []
    body << I18n.t('code_cant_be_blank') unless params[:registered_number]
    body << I18n.t('balance_cant_be_blank') unless params[:balance]
    return render status: :precondition_failed, json: body unless body.empty?
  end
end
