class AddPublishedColumnToService < ActiveRecord::Migration
  def change
    add_column :services, :published, :boolean, null: false, default: false
  end
end
