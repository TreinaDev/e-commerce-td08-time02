class Product < ApplicationRecord
  enum status: {pending: 0, paid: 5, refused: 10}

  validates :name, :brand, :description, :sku, :width, :height, :depth, :weight, :fragile, presence: true
end
