class Purchase < ApplicationRecord
  belongs_to :client
  has_many :product_items, dependent: :nullify
  enum status: { pending: 0, approved: 5, rejected: 10 }

  validates :cashback_value, numericality: { greater_than_or_equal_to: 0.0 }
end
