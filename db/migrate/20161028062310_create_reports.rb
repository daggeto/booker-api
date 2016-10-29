class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true
      t.string :message, null: false

      t.timestamps null: false
    end
  end
end
