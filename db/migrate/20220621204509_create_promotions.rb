class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.date :start_date
      t.date :end_date
      t.string :name
      t.integer :discount_percentual
      t.decimal :discount_max
      t.integer :used_times
      t.string :coupon
      t.integer :usage_limit
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
