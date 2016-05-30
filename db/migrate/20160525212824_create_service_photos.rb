class CreateServicePhotos < ActiveRecord::Migration
  def change
    create_table :service_photos do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
