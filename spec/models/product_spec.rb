require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:brand) }

    it { is_expected.to validate_presence_of(:description) }

    it { is_expected.to validate_presence_of(:height) }

    it { is_expected.to validate_presence_of(:weight) }

    it { is_expected.to validate_presence_of(:width) }

    it { is_expected.to validate_presence_of(:depth) }

    it { is_expected.to validate_uniqueness_of(:sku) }

    it { is_expected.to have_many_attached(:photos) }

    it { is_expected.to validate_numericality_of(:height).is_greater_than(0.0) }

    it { is_expected.to validate_numericality_of(:weight).is_greater_than(0.0) }

    it { is_expected.to validate_numericality_of(:width).is_greater_than(0.0) }

    it { is_expected.to validate_numericality_of(:depth).is_greater_than(0.0) }

    it { is_expected.to belong_to(:category) }
  end

  describe '#set_rubies_shipping_price' do
    it 'Converte valor do frete com sucesso' do
      create :exchange_rate, value: 2.0
      product = build :product, shipping_price: 20.00

      product.set_rubies_shipping_price

      expect(product.rubies_shipping_price).to eq 10.00
    end

    it 'Converte valor do frete quando o produto é criado' do
      create :exchange_rate, value: 2.0

      product = create :product, shipping_price: 20.00

      expect(product.rubies_shipping_price).to eq 10.00
    end

    it 'Não é executado quando não há taxa de câmbio' do
      product = create :product, shipping_price: 20.00

      expect(product.rubies_shipping_price).to be_nil
    end
  end

  describe '#create_stock' do
    it 'Cria um estoque ao criar um produto' do
      product = create :product
    
      expect(product.stock_product).not_to be_nil
    end
  end
end
