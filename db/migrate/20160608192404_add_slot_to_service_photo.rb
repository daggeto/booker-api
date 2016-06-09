class AddSlotToServicePhoto < ActiveRecord::Migration
  def change
    add_column :service_photos, :slot, :integer, null: false
  end
end
