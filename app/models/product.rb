class Product < ApplicationRecord
  enum status: { inactive: 0, active: 5 }

  validates :name, :brand, :description, :sku, :width, :height, :depth, :weight, :shipping_price, presence: true
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, :shipping_price, numericality: { greater_than: 0.0 }

  has_many :prices, dependent: :nullify
  accepts_nested_attributes_for :prices
  has_one_attached :manual
  has_many_attached :photos

  def current_price
    price = prices.find_by(
      'start_date <= current_date AND end_date >= current_date', current_date: Time.zone.today
    )
    price.value
  end
end
