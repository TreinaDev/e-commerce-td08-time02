class Product < ApplicationRecord
  belongs_to :category
  belongs_to :cashback, optional: true
  enum status: { inactive: 0, active: 5 }

  validates :name, :brand, :description, :sku, :width, :height, :depth, :weight, :shipping_price, presence: true
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, :shipping_price, numericality: { greater_than: 0.0 }

  has_many :prices, dependent: :nullify
  has_many :product_items, dependent: :nullify
  has_many :reviews, dependent: :nullify
  accepts_nested_attributes_for :prices
  has_one_attached :manual
  has_one :stock_product
  has_many_attached :photos

  before_create :set_rubies_shipping_price
  after_create :create_stock

  def set_rubies_shipping_price
    return unless shipping_price && ExchangeRate.last

    self.rubies_shipping_price = shipping_price / ExchangeRate.last.value
  end

  def current_price
    prices.find_by('start_date <= current_date AND end_date >= current_date', current_date: Time.zone.today)
  end

  private

  def create_stock
    StockProduct.create!(product: self, quantity: 0)
  end
end
