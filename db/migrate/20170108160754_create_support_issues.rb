class CreateSupportIssues < ActiveRecord::Migration
  def change
    create_table :support_issues do |t|
      t.references :user, index: true, foreign_key: true

      t.text :message, null: false
      t.string :platform
      t.string :version
      t.string :app_version
      t.text :device_details

      t.timestamps null: false
    end
  end
end
