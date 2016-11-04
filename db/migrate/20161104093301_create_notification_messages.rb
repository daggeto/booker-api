class CreateNotificationMessages < ActiveRecord::Migration
  def change
    create_table :notification_messages do |t|
      t.datetime :created
      t.string :uuid
      t.string :notification_uuid
      t.string :status
      t.string :error

      t.references :notification, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
