require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  it { is_expected.to validate_presence_of(:value) }

  describe '#delete_old_rate' do
    it 'com sucesso' do
      create :exchange_rate, value: 1.5

      create :exchange_rate, value: 2.0

      expect(described_class.count).to eq 1
      expect(described_class.last.value).to eq 2.0
    end

    it 'sem taxas passadas' do
      create :exchange_rate, value: 2.0

      expect(described_class.count).to eq 1
      expect(described_class.last.value).to eq 2.0
    end
  end
end
