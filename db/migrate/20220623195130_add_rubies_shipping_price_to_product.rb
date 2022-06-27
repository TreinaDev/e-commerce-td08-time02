class AddRubiesShippingPriceToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :rubies_shipping_price, :decimal
  end
end
