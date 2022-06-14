class ChangeDefaultValueStatusToProduct < ActiveRecord::Migration[7.0]
  def change
    change_column_default :products, :status, 0
  end
end
