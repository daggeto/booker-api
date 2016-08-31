class AddIndexForCreatedAtInReservations < ActiveRecord::Migration
  def change
    add_index :reservations, :created_at
  end
end
