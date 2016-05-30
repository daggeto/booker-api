class AddAttachmentImageToServicePhotos < ActiveRecord::Migration
  def self.up
    change_table :service_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :service_photos, :image
  end
end
