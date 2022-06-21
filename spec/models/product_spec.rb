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
end
