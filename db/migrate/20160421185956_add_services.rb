class AddServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.integer :duration, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
