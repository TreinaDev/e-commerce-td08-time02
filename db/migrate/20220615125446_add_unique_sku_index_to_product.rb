class AddUniqueSkuIndexToProduct < ActiveRecord::Migration[7.0]
  def up
    add_index :products, :sku, unique: true
  end

  def down
    remove_index :products, :sku
  end
end
