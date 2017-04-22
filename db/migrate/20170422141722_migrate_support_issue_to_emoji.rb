class MigrateSupportIssueToEmoji < ActiveRecord::Migration
  def change
    execute('
      ALTER TABLE `support_issues` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `platform` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `version` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
      MODIFY `app_version` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    ')
  end
end
