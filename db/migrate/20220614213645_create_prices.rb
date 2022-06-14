class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.references :admin, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :value
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
