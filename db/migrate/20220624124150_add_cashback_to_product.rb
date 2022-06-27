class AddCashbackToProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :cashback, null: true, foreign_key: true
  end
end
