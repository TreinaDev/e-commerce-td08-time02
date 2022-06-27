class CreateExchangeRates < ActiveRecord::Migration[7.0]
  def change
    create_table :exchange_rates do |t|
      t.float :value, null: false

      t.timestamps
    end
  end
end
