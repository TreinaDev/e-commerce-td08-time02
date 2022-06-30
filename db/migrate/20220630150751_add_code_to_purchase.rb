class AddCodeToPurchase < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :code, :string, null: false
  end
end
