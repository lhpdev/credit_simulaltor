class AddUsersReferenceToSimulation < ActiveRecord::Migration[8.0]
  def change
    add_reference :simulations, :user, null: false, foreign_key: true
  end
end
