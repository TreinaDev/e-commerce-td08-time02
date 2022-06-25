require 'rails_helper'

RSpec.describe Cashback, type: :model do
  it { is_expected.to validate_presence_of(:start_date) }

  it { is_expected.to validate_presence_of(:end_date) }

  it { is_expected.to validate_presence_of(:percentual) }

  it { is_expected.to validate_numericality_of(:percentual).is_greater_than(0) }

  it { is_expected.to belong_to(:admin) }

  it { is_expected.to have_many(:products) }

  it 'false se data inicial for maior que data final' do
    cashback = described_class.new(start_date: 1.day.from_now, end_date: Time.zone.today)

    cashback.valid?

    expect(cashback.errors[:start_date]).to include 'não pode ser maior que a data final'
  end

  it 'true se data inicial for menor que data final' do
    cashback = described_class.new(start_date: Time.zone.today, end_date: 1.day.from_now)

    cashback.valid?

    expect(cashback.errors.include?(:start_date)).to be false
  end

  it 'false se data inicial for anterior à data atual' do
    cashback = described_class.new(start_date: 1.day.ago)

    cashback.valid?

    expect(cashback.errors[:start_date]).to include 'não pode ser anterior a hoje'
  end

  it 'true se data inicial for igual ou posterior à data atual' do
    cashback = described_class.new(start_date: Time.zone.today)

    cashback.valid?

    expect(cashback.errors.include?(:start_date)).to be false
  end
end
