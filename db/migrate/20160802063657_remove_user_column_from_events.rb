class RemoveUserColumnFromEvents < ActiveRecord::Migration
  def change
    remove_reference(:events, :user, index: true, foreign_key: true)
  end
end
