class AddIndexForClientIdInDevices < ActiveRecord::Migration
  def change
    add_index :devices, :client_id
  end
end
