require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  it { is_expected.to belong_to(:client).optional }
  it { is_expected.to belong_to(:purchase).optional }
  it { is_expected.to belong_to(:product) }

  describe '#discount_value' do
    it 'retorna valor absoluto do desconto' do
      create :exchange_rate, value: 2.0
      promotion = create :promotion, start_date: Time.zone.today, end_date: 1.day.from_now, discount_percentual: 20
      category = create :category, promotion: promotion
      product = create :product, category: category
      create :price, product: product, value: 20.00
      item = create :product_item, product: product, quantity: 2

      expect(item.discount_value).to eq 4.00
    end

    it 'retorna 0.0 se não houver desconto' do
      create :exchange_rate, value: 2.0
      promotion = create :promotion, start_date: 1.day.from_now, end_date: 2.days.from_now, discount_percentual: 10
      category = create :category, promotion: promotion
      product = create :product, category: category
      create :price, product: product, value: 20.00
      item = create :product_item, product: product, quantity: 2

      expect(item.discount_value).to eq 0.00
    end
  end

  describe '#total_price' do
    it 'retorna soma dos valores dos produtos comprados - desconto' do
      create :exchange_rate, value: 2.0
      promotion = create :promotion, start_date: Time.zone.today, end_date: 1.day.from_now, discount_percentual: 20
      category = create :category, promotion: promotion
      product = create :product, category: category
      create :price, product: product, value: 20.00
      item = create :product_item, product: product, quantity: 2

      expect(item.total_price).to eq 16.00
    end

    it 'retorna apenas soma dos valores dos produtos comprados quando não há desconto' do
      create :exchange_rate, value: 2.0
      product = create :product
      create :price, product: product, value: 20.00
      item = create :product_item, product: product, quantity: 2

      expect(item.total_price).to eq 20.00
    end
  end
end
