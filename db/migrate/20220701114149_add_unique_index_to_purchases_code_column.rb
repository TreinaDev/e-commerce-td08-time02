class AddUniqueIndexToPurchasesCodeColumn < ActiveRecord::Migration[7.0]
  def change
    add_index :purchases, :code, unique: true
  end
end
