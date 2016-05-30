class AddServiceReferenceToServicePhotos < ActiveRecord::Migration
  def change
    add_reference :service_photos, :service, index: true, foreign_key: true
  end
end
