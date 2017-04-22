class ConvertDatabaseToUtf8mb4 < ActiveRecord::Migration
  def change
    execute('
      ALTER TABLE `events` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `description` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `status` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    ')
  end
end
