class Product < ApplicationRecord
  belongs_to :category
  enum status: { inactive: 0, active: 5 }

  validates :name, :brand, :description, :sku, :width, :height, :depth, :weight, presence: true
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0.0 }

  has_many :prices, dependent: :nullify
  has_one_attached :manual
  has_many_attached :photos
end
