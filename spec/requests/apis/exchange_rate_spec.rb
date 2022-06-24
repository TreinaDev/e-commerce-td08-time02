require 'rails_helper'

describe 'Exchange Rate API' do
  context 'POST /api/v1/exchange_rates' do
    it 'Bem-sucedido' do
      create :exchange_rate, value: 2.0
      product = create :product, shipping_price: 50.00
      first_price = create :price, admin: product.category.admin, product: product, value: 100.00,
                                   start_date: Time.zone.today, end_date: 2.days.from_now
      second_price = create :price, admin: first_price.admin, product: first_price.product, value: 75.00,
                                    start_date: 3.days.from_now, end_date: 4.days.from_now

      post '/api/v1/exchange_rates', params: { exchange_rate: 1.5 }
      product.reload
      first_price.reload
      second_price.reload

      expect(ExchangeRate.count).to eq 1
      expect(ExchangeRate.last.value).to eq 1.5
      expect(product.rubies_shipping_price).to eq 50.00 / 1.5
      expect(first_price.rubies_value).to eq 100.00 / 1.5
      expect(second_price.rubies_value).to eq 75.00 / 1.5
    end
  end
end
