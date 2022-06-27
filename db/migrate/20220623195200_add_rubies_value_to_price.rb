class AddRubiesValueToPrice < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :rubies_value, :decimal
  end
end
