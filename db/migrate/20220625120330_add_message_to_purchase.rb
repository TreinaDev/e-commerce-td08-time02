class AddMessageToPurchase < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :message, :string
  end
end
