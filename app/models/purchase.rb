class Purchase < ApplicationRecord
  belongs_to :client
  has_many :product_items, dependent: :nullify
  enum status: { pending: 0, approved: 5, rejected: 10 }
end
