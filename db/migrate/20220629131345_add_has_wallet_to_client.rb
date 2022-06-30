class AddHasWalletToClient < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :has_wallet, :boolean, default: false
  end
end
