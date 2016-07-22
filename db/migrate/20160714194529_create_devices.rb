class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :token
      t.string :platform
      t.string :client_id

      t.references :user, index: true, foreign_key: true
    end
  end
end
