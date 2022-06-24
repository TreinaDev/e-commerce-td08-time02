class ExchangeRate < ApplicationRecord
  validates :value, presence: true
end
