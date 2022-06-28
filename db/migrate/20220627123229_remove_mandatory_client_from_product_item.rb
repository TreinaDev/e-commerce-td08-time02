class RemoveMandatoryClientFromProductItem < ActiveRecord::Migration[7.0]
  def change
    change_column :product_items, :client_id, :integer, null: true
  end
end
