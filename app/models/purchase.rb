class Purchase < ApplicationRecord
  belongs_to :client
  has_many :product_items, dependent: :nullify
  enum status: { pending: 0, approved: 5, rejected: 10 }

  before_validation :calculate_value

  private

  def calculate_value
    self.value = 0
    product_items.each do |item|
      self.value += (item.product.current_price * item.quantity) + item.product.shipping_price
    end
  end
end
