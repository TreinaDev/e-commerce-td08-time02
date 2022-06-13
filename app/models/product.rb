class Product < ApplicationRecord
  enum status: { inactive: 0, active: 5 }

  validates :name, :brand, :description, :sku, :width, :height, :depth, :weight, :fragile, presence: true
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0.0 }

  has_one_attached :manual
  has_one_attached :photo
end
