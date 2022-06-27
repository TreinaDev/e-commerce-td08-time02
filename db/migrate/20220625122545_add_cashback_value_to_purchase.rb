class AddCashbackValueToPurchase < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :cashback_value, :decimal, default: 0.0
  end
end
