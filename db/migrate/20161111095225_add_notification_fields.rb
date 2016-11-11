class AddNotificationFields < ActiveRecord::Migration
  def change
    add_column :notifications, :title, :string
    add_column :notifications, :message, :text
    add_column :notifications, :payload, :text
  end
end
