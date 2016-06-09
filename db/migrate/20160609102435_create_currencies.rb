class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies, id: :string, limit: 3 do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
