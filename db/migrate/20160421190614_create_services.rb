class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, null: false, default: 'My Activity'
      t.integer :duration, null: false, default: 60
      t.integer :price, null: false, default: 0

      t.timestamps null: false
    end
  end
end
