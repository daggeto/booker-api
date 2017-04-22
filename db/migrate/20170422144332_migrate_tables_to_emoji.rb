class MigrateTablesToEmoji < ActiveRecord::Migration
  def change
    execute('
      ALTER TABLE `services` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `name` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `phone` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `address` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `description` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    ')

    execute('
      ALTER TABLE `reports` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `message` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    ')

    execute('
      ALTER TABLE `notifications` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `title` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `tokens` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `payload` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `uuid` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `profile` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `sender_type` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    ')
  end
end
