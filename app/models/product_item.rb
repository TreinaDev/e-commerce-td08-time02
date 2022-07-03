class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :client, optional: true
  belongs_to :purchase, optional: true

  def total_price
    (product.current_price.rubies_value * quantity) - discount_value
  end

  def total_shipping_price
    product.rubies_shipping_price * quantity
  end

  def discount_value
    sale = product.category.promotion
    return 0.0 unless sale&.is_valid_status == 'Vigente'

    (product.current_price.rubies_value * (sale.discount_percentual.to_d / 100)) * quantity
  end

  def cashback_value
    return 0.0 unless product.cashback

    total_price / product.cashback.percentual
  end
end
