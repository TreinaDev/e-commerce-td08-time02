class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :client, optional: true
  belongs_to :purchase, optional: true

  def define_product_total_price
    product.current_price.rubies_value * quantity
  end

  def define_product_shipping_price
    product.rubies_shipping_price * quantity
  end
end
