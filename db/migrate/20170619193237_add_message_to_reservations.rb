class AddMessageToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :message, :string, after: :user_id
  end
end
