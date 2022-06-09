class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.string :description
      t.string :sku
      t.decimal :width
      t.decimal :height
      t.decimal :depth
      t.decimal :weight
      t.decimal :shipping_price
      t.boolean :fragile
      t.integer :status

      t.timestamps
    end
  end
end
