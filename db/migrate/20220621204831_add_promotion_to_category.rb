class AddPromotionToCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :promotion, null: true, foreign_key: true
  end
end
