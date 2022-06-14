require 'rails_helper'

RSpec.describe Price, type: :model do
  it { is_expected.to belong_to(:admin) }

  it { is_expected.to belong_to(:product) }

  it { is_expected.to validate_presence_of(:value) }

  it { is_expected.to validate_presence_of(:start_date) }

  it { is_expected.to validate_presence_of(:end_date) }

  it { is_expected.to validate_numericality_of(:value).is_greater_than(0.0) }

  it 'false se data inicial for maior que data final' do
    price = described_class.new(start_date: 1.day.from_now, end_date: Date.today)

    price.valid?

    expect(price.errors[:start_date]).to include 'não pode ser maior que a data final'
  end

  it 'false se data inicial for anterior à data atual' do
    price = described_class.new(start_date: 1.day.ago)

    price.valid?

    expect(price.errors[:start_date]).to include 'não pode ser anterior a hoje'
  end

  it 'false se intervalo já estiver cadastrado' do
    admin = create :admin
    product = create :product
    described_class.create!(admin: admin, product: product, start_date: Date.today, end_date: 1.week.from_now,
                            value: 30.00)
    price = described_class.new(product: product, start_date: 1.day.from_now, end_date: 3.days.from_now)

    product.reload
    price.valid?

    expect(price.errors[:start_date]).to include 'não pode estar inclusa em intervalo já cadastrado'
    expect(price.errors[:end_date]).to include 'não pode estar inclusa em intervalo já cadastrado'
  end
end
