class Api::V1::ExchangeRatesController < ActionController::API
  def create
    ExchangeRate.create!(value: params[:exchange_rate])
    Product.all.each do |product|
      product.set_rubies_shipping_price

      product.prices.where('start_date >= ?', Time.zone.today).each do |price|
        price.set_rubies_value
        price.save
      end

      product.save
    end
  end
end
