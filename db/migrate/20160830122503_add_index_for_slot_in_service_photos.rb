class AddIndexForSlotInServicePhotos < ActiveRecord::Migration
  def change
    add_index :service_photos, :slot
  end
end
