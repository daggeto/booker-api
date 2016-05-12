class AddPhoneAndAddressToService < ActiveRecord::Migration
  def change
    add_column :services, :phone, :integer
    add_column :services, :address, :string
  end
end
