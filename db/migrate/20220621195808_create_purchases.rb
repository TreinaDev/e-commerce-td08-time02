class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :client, null: false, foreign_key: true
      t.decimal :value
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
