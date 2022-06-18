require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  it { is_expected.to belong_to(:client) }
  it { is_expected.to belong_to(:product) }
end
