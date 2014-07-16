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

ActiveRecord::Schema.define(version: 20140716054727) do

  create_table "albums", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id"
  end

  add_index "albums", ["house_id"], name: "index_albums_on_house_id"
  add_index "albums", ["user_id"], name: "index_albums_on_user_id"

  create_table "authentications", force: true do |t|
    t.integer  "user_id",      null: false
    t.string   "provider",     null: false
    t.string   "uid",          null: false
    t.string   "access_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.time     "accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", force: true do |t|
    t.string   "identifier"
    t.string   "name"
    t.string   "region"
    t.string   "address"
    t.string   "house_type"
    t.string   "rent_type"
    t.decimal  "area"
    t.integer  "house_count"
    t.integer  "floor"
    t.string   "floor_type"
    t.string   "capacity"
    t.string   "bed"
    t.string   "direction"
    t.text     "facility"
    t.text     "environment"
    t.text     "service"
    t.text     "surrounding"
    t.string   "checkin"
    t.string   "checkout"
    t.string   "open"
    t.string   "close"
    t.integer  "max_day"
    t.integer  "min_day"
    t.text     "other"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geo_address"
  end

  add_index "houses", ["user_id"], name: "index_houses_on_user_id"

  create_table "information", force: true do |t|
    t.integer  "user_id"
    t.integer  "login_count"
    t.string   "rank"
    t.decimal  "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "information", ["user_id"], name: "index_information_on_user_id"

  create_table "notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], name: "index_notifications_on_conversation_id"

  create_table "orders", force: true do |t|
    t.integer  "house_id"
    t.integer  "user_id"
    t.date     "from"
    t.date     "to"
    t.decimal  "price"
    t.decimal  "deposit"
    t.decimal  "payment"
    t.string   "name"
    t.string   "phone"
    t.boolean  "is_oneself"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["house_id"], name: "index_orders_on_house_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "photos", force: true do |t|
    t.integer  "album_id"
    t.string   "title"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id"

  create_table "prices", force: true do |t|
    t.integer  "house_id"
    t.decimal  "day"
    t.date     "start"
    t.date     "end"
    t.decimal  "mon"
    t.decimal  "tue"
    t.decimal  "wed"
    t.decimal  "thu"
    t.decimal  "fri"
    t.decimal  "sat"
    t.decimal  "sun"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prices", ["house_id"], name: "index_prices_on_house_id"

  create_table "receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "receipts", ["notification_id"], name: "index_receipts_on_notification_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
