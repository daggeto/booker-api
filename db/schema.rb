# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170422144332) do

  create_table "devices", force: :cascade do |t|
    t.string  "token",     limit: 255
    t.string  "platform",  limit: 255
    t.string  "client_id", limit: 255
    t.integer "user_id",   limit: 4
  end

  add_index "devices", ["client_id"], name: "index_devices_on_client_id", using: :btree
  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "description", limit: 255
    t.string   "status",      limit: 255
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "service_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["end_at"], name: "index_events_on_end_at", using: :btree
  add_index "events", ["service_id"], name: "index_events_on_service_id", using: :btree
  add_index "events", ["start_at"], name: "index_events_on_start_at", using: :btree
  add_index "events", ["status"], name: "index_events_on_status", using: :btree

  create_table "notification_messages", force: :cascade do |t|
    t.datetime "created"
    t.string   "uuid",              limit: 255
    t.string   "notification_uuid", limit: 255
    t.string   "status",            limit: 255
    t.string   "error",             limit: 255
    t.integer  "notification_id",   limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "notification_messages", ["notification_id"], name: "index_notification_messages_on_notification_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "uuid",           limit: 191
    t.string   "profile",        limit: 191
    t.text     "tokens",         limit: 65535
    t.integer  "reservation_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id",        limit: 4
    t.string   "title",          limit: 191
    t.text     "message",        limit: 65535
    t.text     "payload",        limit: 65535
    t.integer  "sender_id",      limit: 4
    t.string   "sender_type",    limit: 191
  end

  add_index "notifications", ["reservation_id"], name: "index_notifications_on_reservation_id", using: :btree
  add_index "notifications", ["sender_type", "sender_id"], name: "index_notifications_on_sender_type_and_sender_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "profile_images", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id",            limit: 4
  end

  add_index "profile_images", ["user_id"], name: "index_profile_images_on_user_id", using: :btree

  create_table "read_marks", force: :cascade do |t|
    t.integer  "readable_id",   limit: 4
    t.string   "readable_type", limit: 255, null: false
    t.integer  "reader_id",     limit: 4
    t.string   "reader_type",   limit: 255, null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "service_id", limit: 4
    t.string   "message",    limit: 191
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "reports", ["service_id"], name: "index_reports_on_service_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "event_id",    limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "approved_at"
    t.datetime "reminded_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "reservations", ["created_at"], name: "index_reservations_on_created_at", using: :btree
  add_index "reservations", ["event_id"], name: "index_reservations_on_event_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "service_photos", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "service_id",         limit: 4
    t.integer  "slot",               limit: 4,   null: false
  end

  add_index "service_photos", ["service_id"], name: "index_service_photos_on_service_id", using: :btree
  add_index "service_photos", ["slot"], name: "index_service_photos_on_slot", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name",        limit: 191
    t.integer  "duration",    limit: 4,     default: 60,    null: false
    t.integer  "price",       limit: 4,     default: 0,     null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "phone",       limit: 191
    t.string   "address",     limit: 191
    t.integer  "user_id",     limit: 4
    t.boolean  "published",                 default: false, null: false
    t.text     "description", limit: 65535
  end

  add_index "services", ["name"], name: "index_services_on_name", using: :btree
  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "support_issues", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.text     "message",        limit: 65535
    t.string   "platform",       limit: 191
    t.string   "version",        limit: 191
    t.string   "app_version",    limit: 191
    t.text     "device_details", limit: 16777215
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "support_issues", ["user_id"], name: "index_support_issues_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               limit: 191
    t.string   "uid",                    limit: 191
    t.string   "encrypted_password",     limit: 191
    t.string   "reset_password_token",   limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,        default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 191
    t.string   "last_sign_in_ip",        limit: 191
    t.string   "confirmation_token",     limit: 191
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 191
    t.string   "name",                   limit: 191
    t.string   "nickname",               limit: 191
    t.string   "image",                  limit: 191
    t.string   "email",                  limit: 191
    t.text     "tokens",                 limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 191
    t.string   "last_name",              limit: 191
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "devices", "users"
  add_foreign_key "events", "services"
  add_foreign_key "notification_messages", "notifications"
  add_foreign_key "notifications", "reservations"
  add_foreign_key "notifications", "users"
  add_foreign_key "profile_images", "users"
  add_foreign_key "reports", "services"
  add_foreign_key "reports", "users"
  add_foreign_key "reservations", "events"
  add_foreign_key "reservations", "users"
  add_foreign_key "service_photos", "services"
  add_foreign_key "services", "users"
  add_foreign_key "support_issues", "users"
end
