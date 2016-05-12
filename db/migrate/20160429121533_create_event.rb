class CreateEvent < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string :description
      t.string :status
      t.datetime :start_at
      t.datetime :end_at

      t.references :service, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end

    add_index :events, :status
  end

  def down
    drop_table :events
  end
end
