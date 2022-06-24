require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it { is_expected.to belong_to(:client) }

  it { is_expected.to have_many(:product_items) }

  it { is_expected.to define_enum_for(:status).with_values(pending: 0, approved: 5, rejected: 10) }
end
