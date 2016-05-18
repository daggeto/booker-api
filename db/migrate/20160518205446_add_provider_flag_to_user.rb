class AddProviderFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :boolean, default: 0
  end
end
