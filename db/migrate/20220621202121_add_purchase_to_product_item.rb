class AddPurchaseToProductItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_items, :purchase, foreign_key: true
  end
end
