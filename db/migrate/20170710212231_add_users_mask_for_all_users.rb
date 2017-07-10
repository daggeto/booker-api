class AddUsersMaskForAllUsers < ActiveRecord::Migration
  def change
    execute('UPDATE users SET roles_mask = 1')
  end
end
