class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :client


  def get_product_total_price
    self.product.current_price*self.quantity
  end

  def get_product_shipping_price
    self.product.shipping_price*self.quantity
  end
end
