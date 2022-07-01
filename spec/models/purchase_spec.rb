require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe '#valid?' do
    it { is_expected.to belong_to(:client) }

    it { is_expected.to have_many(:product_items) }

    it { is_expected.to define_enum_for(:status).with_values(pending: 0, approved: 5, rejected: 10) }

    it { is_expected.to validate_numericality_of(:cashback_value).is_greater_than_or_equal_to(0.0) }

    it { is_expected.to validate_numericality_of(:value).is_greater_than_or_equal_to(0.0) }

    it 'falso quando code já está em uso' do
      client = create :client
      allow(SecureRandom).to receive(:alphanumeric).and_return('S11EDJCY')
      create :purchase, client: client, value: 20.00
      purchase = build :purchase, code: 'S11EDJCY'

      expect(purchase).not_to be_valid
    end

    context 'valor de compra >= valor de cashback' do
      it 'false' do
        purchase = build :purchase, value: 0.11, cashback_value: 0.12

        purchase.valid?

        expect(purchase.errors[:value]).to include 'não pode ser menor que o valor de cashback'
      end

      it 'true' do
        purchase = build :purchase, value: 0.12, cashback_value: 0.11

        purchase.valid?

        expect(purchase.errors.include?(:value)).to be false
      end
    end

    describe 'Code é gerado automaticamente' do
      it 'Ao criar um novo record' do
        client = create :client
        purchase = described_class.create(client: client, value: 20.0, cashback_value: 5.0)

        expect(purchase.code).not_to be_nil
      end
    end
  end
end
