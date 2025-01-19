class CreateSimulations < ActiveRecord::Migration[8.0]
  def change
    create_table :simulations do |t|
      t.float :value, null: false
      t.date :birthdate, null: false
      t.integer :term_in_months, null: false

      t.timestamps
    end
  end
end
