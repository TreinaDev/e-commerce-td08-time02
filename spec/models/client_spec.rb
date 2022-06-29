require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#valid?' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:code) }

    it { is_expected.to validate_numericality_of(:balance).is_greater_than_or_equal_to 0.0 }

    describe '.code_is_valid' do
      it 'verdadeiro se CPF é válido' do
        client = described_class.new(code: '510.808.180-49')
        client.valid?
        expect(client.errors.include?(:code)).to be false
      end

      it 'falso se CPF não é válido' do
        client = described_class.new(code: '50.88.180-49')
        client.valid?
        expect(client.errors[:code]).to include 'inválido'
      end

      it 'verdadeiro se CNPJ é válido' do
        client = described_class.new(code: '82.425.181/0001-62')
        client.valid?

        expect(client.errors.include?(:code)).to be false
      end

      it 'falso se CNPJ não é válido' do
        client = described_class.new(code: '823.425.181/0001-62')
        client.valid?

        expect(client.errors[:code]).to include 'inválido'
      end
    end
  end

  describe '.code_numbers' do
    it 'remove caracteres especiais do code com sucesso' do
      client = create(:client, code: '82.425.181/0001-62')

      expect(client.code_numbers).to eq '82425181000162'
    end
  end

  describe '.purchase_value' do
    it 'retorna valor total dos itens comprados em rubis' do
      create :exchange_rate, value: 2.0
      client = create :client
      first_product = create :product, name: 'Monitor 8k'
      create :price, product: first_product, value: 10.00
      second_product = create :product, name: 'Mouse', category: first_product.category
      create :price, product: second_product, value: 20.00
      create :product_item, client: client, product: first_product
      create :product_item, client: client, product: second_product, quantity: 2

      expect(client.purchase_value).to eq 25.00
    end
  end

  describe '.shipping_value' do
    it 'retorna valor total do frete em rubis' do
      create :exchange_rate, value: 2.0
      client = create :client
      first_product = create :product, name: 'Monitor 8k', shipping_price: 10.00
      create :price, product: first_product
      second_product = create :product, name: 'Mouse', category: first_product.category, shipping_price: 20.00
      create :price, product: second_product
      create :product_item, client: client, product: first_product
      create :product_item, client: client, product: second_product, quantity: 2

      expect(client.purchase_shipping_value).to eq 25.00
    end
  end
end
