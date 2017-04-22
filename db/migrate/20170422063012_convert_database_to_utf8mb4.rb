class ConvertDatabaseToUtf8mb4 < ActiveRecord::Migration
  def change
    change_column :users, :first_name, :string, limit: 191
    change_column :users, :last_name, :string, limit: 191

    execute('
      ALTER TABLE `users` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `first_name` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `last_name` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    ')
  end
end
