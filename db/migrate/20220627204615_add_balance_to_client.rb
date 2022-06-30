class AddBalanceToClient < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :balance, :decimal, null: false, default: 0.0
  end
end
