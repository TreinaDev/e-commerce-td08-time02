class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_balance, if: :client_signed_in?

  protected

  def get_balance
    @saldo = GetBalance.get_balance(current_client.code)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name code])
  end
end
