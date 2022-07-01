class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :client, optional: true
  belongs_to :purchase, optional: true

  def total_price
    product.current_price.rubies_value * quantity
  end

  def total_shipping_price
    product.rubies_shipping_price * quantity
  end

  def cashback_value
    return 0.0 unless product.cashback

    total_price / product.cashback.percentual
  end
end
