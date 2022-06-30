class Review < ApplicationRecord
  belongs_to :client
  belongs_to :product

  validates :rating, :comment, presence: true
  validates :rating, inclusion: 0..5
end
