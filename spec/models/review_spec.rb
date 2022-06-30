require 'rails_helper'

RSpec.describe Review, type: :model do
  it { is_expected.to validate_presence_of(:rating) }

  it { is_expected.to validate_presence_of(:comment) }

  it { is_expected.to validate_inclusion_of(:rating).in_range(0..5) }

  it { is_expected.to belong_to(:client) }

  it { is_expected.to belong_to(:product) }
end
