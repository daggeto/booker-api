class AddIndexForNameInService < ActiveRecord::Migration
  def change
    add_index :services, :name
  end
end
