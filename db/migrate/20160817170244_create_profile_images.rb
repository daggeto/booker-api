class CreateProfileImages < ActiveRecord::Migration
  def change
    create_table :profile_images do |t|
      t.attachment :image

      t.timestamps null: false
    end

    add_reference :profile_images, :user, index: true, foreign_key: true
  end
end
