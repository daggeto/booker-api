class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :uuid
      t.string :profile
      t.text :tokens

      t.references :reservation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
