class ChangeServiceNameToAllowNulls < ActiveRecord::Migration
  def change
    change_column :services, :name, :string, default: nil, :null => true
  end
end
