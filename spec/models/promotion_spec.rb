require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe '#valid' do
    it { is_expected.to validate_presence_of(:start_date) }

    it { is_expected.to validate_presence_of(:end_date) }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:discount_max) }

    it { is_expected.to validate_presence_of(:discount_percentual) }

    it { is_expected.to validate_presence_of(:used_times) }

    it { is_expected.to validate_presence_of(:usage_limit) }

    it { is_expected.to validate_numericality_of(:discount_max).is_greater_than(0) }

    it { is_expected.to validate_numericality_of(:discount_percentual).is_greater_than(0) }

    it { is_expected.to validate_numericality_of(:usage_limit).is_greater_than(0) }
    
    it { is_expected.to validate_numericality_of(:used_times).is_greater_than_or_equal_to(0) }

    it { is_expected.to belong_to(:admin) }

    it 'true se limite de uso for maior ou igual a quantidade usada' do
      promotion = described_class.new(usage_limit: 10, used_times: 10)

      promotion.valid?

      expect(promotion.errors.include?(:used_times)).to be false
    end

    it 'false se limite de uso for menor que quantidade usada' do
      promotion = described_class.new(usage_limit: 10, used_times: 11)

      promotion.valid?

      expect(promotion.errors[:used_times]).to include 'não pode ser maior que o limite de usos'
    end

    it 'false se data inicial for maior que data final' do
      promotion = described_class.new(start_date: 1.day.from_now, end_date: Time.zone.today)
  
      promotion.valid?
  
      expect(promotion.errors[:start_date]).to include 'não pode ser maior que a data final'
    end
  
    it 'true se data inicial for menor que data final' do
      promotion = described_class.new(start_date: Time.zone.today, end_date: 1.day.from_now)
  
      promotion.valid?
  
      expect(promotion.errors.include?(:start_date)).to be false
    end
  
    it 'false se data inicial for anterior à data atual' do
      promotion = described_class.new(start_date: 1.day.ago)
  
      promotion.valid?
  
      expect(promotion.errors[:start_date]).to include 'não pode ser anterior a hoje'
    end
  
    it 'true se data inicial for igual ou posterior à data atual' do
      promotion = described_class.new(start_date: Time.zone.today)
  
      promotion.valid?
  
      expect(promotion.errors.include?(:start_date)).to be false
    end

    it 'true se tamanho de coupon for igual a 8' do
      promotion = described_class.new()

      promotion.valid?

      expect(promotion.coupon.length).to eq 8
    end

    it 'false se coupon já existir no banco de dados' do
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
      create :promotion
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
      promotion = described_class.new()

      promotion.valid?
      
      expect(promotion.errors).to include :coupon
    end

    it 'true se coupon não existir no banco de dados' do
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
      create :promotion
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('6789QWER')
      promotion = described_class.new()

      promotion.valid?
      
      expect(promotion.errors).not_to include :coupon
    end
  end
end
