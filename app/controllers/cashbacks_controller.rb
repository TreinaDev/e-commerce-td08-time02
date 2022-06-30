class CashbacksController < ApplicationController
  before_action :authenticate_admin!

  def new
    @cashback = Cashback.new
  end

  def create
    @cashback = Cashback.new(cashback_params)
    @cashback.admin = current_admin
    if @cashback.save
      redirect_to root_path, notice: t('cashback_created')
    else
      flash.now[:alert] = t('cashback_not_created')
      render 'new'
    end
  end

  private

  def cashback_params
    params.require(:cashback).permit(:start_date, :end_date, :percentual)
  end
end
