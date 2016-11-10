class ChangePhoneNumberTypeToString < ActiveRecord::Migration
  def change
    change_column :services, :phone, :string
  end
end
