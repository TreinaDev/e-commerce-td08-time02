class CreateProductItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_items do |t|
      t.integer :quantity, default: 1
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
