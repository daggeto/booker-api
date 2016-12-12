class AddOnDeleteToForeignKeys < ActiveRecord::Migration
  def up
    remove_foreign_key :devices, column: :user_id
    remove_foreign_key :events, column: :service_id
    remove_foreign_key :notification_messages, column: :notification_id
    remove_foreign_key :notifications, column: :reservation_id
    remove_foreign_key :notifications, column: :user_id
    remove_foreign_key :profile_images, column: :user_id
    remove_foreign_key :reports, column: :user_id
    remove_foreign_key :reports, column: :service_id
    remove_foreign_key :reservations, column: :user_id
    remove_foreign_key :reservations, column: :event_id
    remove_foreign_key :service_photos, column: :service_id
    remove_foreign_key :services, column: :user_id

    add_foreign_key :devices, :users, on_delete: :cascade
    add_foreign_key :events, :services, on_delete: :cascade
    add_foreign_key :notification_messages, :notifications, on_delete: :cascade
    add_foreign_key :notifications, :reservations, on_delete: :nullify
    add_foreign_key :notifications, :users, on_delete: :cascade
    add_foreign_key :profile_images, :users, on_delete: :cascade
    add_foreign_key :reports, :users, on_delete: :nullify
    add_foreign_key :reports, :services, on_delete: :nullify
    add_foreign_key :reservations, :users, on_delete: :cascade
    add_foreign_key :reservations, :events, on_delete: :cascade
    add_foreign_key :service_photos, :services, on_delete: :cascade
    add_foreign_key :services, :users, on_delete: :cascade
  end
end
