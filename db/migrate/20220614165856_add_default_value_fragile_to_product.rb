class AddDefaultValueFragileToProduct < ActiveRecord::Migration[7.0]
  def change
    change_column_default :products, :fragile, from: nil, to: false
  end
end
