class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :client
  belongs_to :purchase, optional: true
end
