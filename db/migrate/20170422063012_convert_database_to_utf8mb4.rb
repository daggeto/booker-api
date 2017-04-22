class ConvertDatabaseToUtf8mb4 < ActiveRecord::Migration
  def change
    execute "ALTER TABLE users CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE users CHANGE first_name first_name VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE users CHANGE last_name last_name VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"

    execute "ALTER TABLE support_issues CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE support_issues CHANGE message message VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"

    execute "ALTER TABLE services CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE services CHANGE name name VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE services CHANGE description description VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"

    execute "ALTER TABLE reports CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE reports CHANGE message message VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"

    execute "ALTER TABLE notifications CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE notifications CHANGE title title VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE notifications CHANGE message message VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"

    execute "ALTER TABLE events CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE events CHANGE description description VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end
end
