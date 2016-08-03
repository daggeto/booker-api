class RemoveUnusedColumnsFromReservations < ActiveRecord::Migration
  def change
    remove_column(:reservations, :disapproved_at)
    remove_column(:reservations, :canceled_at)
    remove_column(:reservations, :deleted_at)
  end
end
