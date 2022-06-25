class CreateCashbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :cashbacks do |t|
      t.date :start_date
      t.date :end_date
      t.integer :percentual
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
