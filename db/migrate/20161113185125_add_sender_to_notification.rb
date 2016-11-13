class AddSenderToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :sender, polymorphic: true, index: true
  end
end
