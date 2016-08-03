class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :event, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.datetime :approved_at
      t.datetime :disapproved_at
      t.datetime :canceled_at
      t.datetime :deleted_at
      t.datetime :reminded_at

      t.timestamps null: false
    end
  end
end
