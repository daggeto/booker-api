class AddIndexForDateInEvent < ActiveRecord::Migration
  def change
    add_index :events, :start_at
    add_index :events, :end_at
  end
end
