class AddAdminToCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :admin, null: false, foreign_key: true
  end
end
