class AddDefaultUsedTimesToPromotion < ActiveRecord::Migration[7.0]
  def change
    change_column_default :promotions, :used_times, 0
  end
end
