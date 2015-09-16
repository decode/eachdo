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

ActiveRecord::Schema.define(version: 20150916122428) do

  create_table "albums", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id",    limit: 4
  end

  add_index "albums", ["house_id"], name: "index_albums_on_house_id", using: :btree
  add_index "albums", ["user_id"], name: "index_albums_on_user_id", using: :btree

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",      limit: 4,   null: false
    t.string   "provider",     limit: 255, null: false
    t.string   "uid",          limit: 255, null: false
    t.string   "access_token", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "cid",         limit: 255
    t.string   "name",        limit: 255
    t.string   "term",        limit: 255
    t.string   "status",      limit: 255
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.integer  "school_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "courses", ["cid"], name: "index_courses_on_cid", unique: true, using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "house_id",   limit: 4
    t.integer  "order_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.text     "comment",    limit: 65535
    t.decimal  "rating",                   precision: 10
    t.string   "judgement",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["house_id"], name: "index_feedbacks_on_house_id", using: :btree
  add_index "feedbacks", ["order_id"], name: "index_feedbacks_on_order_id", using: :btree
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "forem_categories", force: :cascade do |t|
    t.string   "name",       limit: 255,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
    t.integer  "position",   limit: 4,   default: 0
  end

  add_index "forem_categories", ["slug"], name: "index_forem_categories_on_slug", unique: true, using: :btree

  create_table "forem_forums", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.text    "description", limit: 65535
    t.integer "category_id", limit: 4
    t.integer "views_count", limit: 4,     default: 0
    t.string  "slug",        limit: 255
    t.integer "position",    limit: 4,     default: 0
  end

  add_index "forem_forums", ["slug"], name: "index_forem_forums_on_slug", unique: true, using: :btree

  create_table "forem_groups", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "forem_groups", ["name"], name: "index_forem_groups_on_name", using: :btree

  create_table "forem_memberships", force: :cascade do |t|
    t.integer "group_id",  limit: 4
    t.integer "member_id", limit: 4
  end

  add_index "forem_memberships", ["group_id"], name: "index_forem_memberships_on_group_id", using: :btree

  create_table "forem_moderator_groups", force: :cascade do |t|
    t.integer "forum_id", limit: 4
    t.integer "group_id", limit: 4
  end

  add_index "forem_moderator_groups", ["forum_id"], name: "index_forem_moderator_groups_on_forum_id", using: :btree

  create_table "forem_posts", force: :cascade do |t|
    t.integer  "topic_id",    limit: 4
    t.text     "text",        limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to_id", limit: 4
    t.string   "state",       limit: 255,   default: "pending_review"
    t.boolean  "notified",                  default: false
  end

  add_index "forem_posts", ["reply_to_id"], name: "index_forem_posts_on_reply_to_id", using: :btree
  add_index "forem_posts", ["state"], name: "index_forem_posts_on_state", using: :btree
  add_index "forem_posts", ["topic_id"], name: "index_forem_posts_on_topic_id", using: :btree
  add_index "forem_posts", ["user_id"], name: "index_forem_posts_on_user_id", using: :btree

  create_table "forem_subscriptions", force: :cascade do |t|
    t.integer "subscriber_id", limit: 4
    t.integer "topic_id",      limit: 4
  end

  create_table "forem_topics", force: :cascade do |t|
    t.integer  "forum_id",     limit: 4
    t.integer  "user_id",      limit: 4
    t.string   "subject",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",                   default: false,            null: false
    t.boolean  "pinned",                   default: false
    t.boolean  "hidden",                   default: false
    t.datetime "last_post_at"
    t.string   "state",        limit: 255, default: "pending_review"
    t.integer  "views_count",  limit: 4,   default: 0
    t.string   "slug",         limit: 255
  end

  add_index "forem_topics", ["forum_id"], name: "index_forem_topics_on_forum_id", using: :btree
  add_index "forem_topics", ["slug"], name: "index_forem_topics_on_slug", unique: true, using: :btree
  add_index "forem_topics", ["state"], name: "index_forem_topics_on_state", using: :btree
  add_index "forem_topics", ["user_id"], name: "index_forem_topics_on_user_id", using: :btree

  create_table "forem_views", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "viewable_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             limit: 4,   default: 0
    t.string   "viewable_type",     limit: 255
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], name: "index_forem_views_on_updated_at", using: :btree
  add_index "forem_views", ["user_id"], name: "index_forem_views_on_user_id", using: :btree
  add_index "forem_views", ["viewable_id"], name: "index_forem_views_on_viewable_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "friend_id",   limit: 4
    t.string   "status",      limit: 255
    t.time     "accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", force: :cascade do |t|
    t.string   "identifier",  limit: 255
    t.string   "name",        limit: 255
    t.string   "region",      limit: 255
    t.string   "province",    limit: 255
    t.string   "city",        limit: 255
    t.string   "district",    limit: 255
    t.string   "address",     limit: 255
    t.string   "house_type",  limit: 255
    t.string   "rent_type",   limit: 255
    t.decimal  "area",                      precision: 10
    t.integer  "house_count", limit: 4
    t.integer  "floor",       limit: 4
    t.string   "floor_type",  limit: 255
    t.string   "capacity",    limit: 255
    t.string   "bed",         limit: 255
    t.string   "direction",   limit: 255
    t.text     "facility",    limit: 65535
    t.text     "environment", limit: 65535
    t.text     "service",     limit: 65535
    t.text     "surrounding", limit: 65535
    t.string   "checkin",     limit: 255
    t.string   "checkout",    limit: 255
    t.string   "open",        limit: 255
    t.string   "close",       limit: 255
    t.integer  "max_day",     limit: 4
    t.integer  "min_day",     limit: 4
    t.text     "other",       limit: 65535
    t.integer  "amount",      limit: 4
    t.string   "status",      limit: 255
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.string   "geo_address", limit: 255
  end

  add_index "houses", ["user_id"], name: "index_houses_on_user_id", using: :btree

  create_table "information", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "login_count", limit: 4
    t.string   "rank",        limit: 255
    t.decimal  "credit",                  precision: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "information", ["user_id"], name: "index_information_on_user_id", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id",   limit: 4
    t.string  "unsubscriber_type", limit: 255
    t.integer "conversation_id",   limit: 4
  end

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    limit: 255, default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type",                 limit: 255
    t.text     "body",                 limit: 65535
    t.string   "subject",              limit: 255,   default: ""
    t.integer  "sender_id",            limit: 4
    t.string   "sender_type",          limit: 255
    t.integer  "conversation_id",      limit: 4
    t.boolean  "draft",                              default: false
    t.datetime "updated_at",                                         null: false
    t.datetime "created_at",                                         null: false
    t.integer  "notified_object_id",   limit: 4
    t.string   "notified_object_type", limit: 255
    t.string   "notification_code",    limit: 255
    t.string   "attachment",           limit: 255
    t.boolean  "global",                             default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id",     limit: 4
    t.string   "receiver_type",   limit: 255
    t.integer  "notification_id", limit: 4,                   null: false
    t.boolean  "is_read",                     default: false
    t.boolean  "trashed",                     default: false
    t.boolean  "deleted",                     default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "house_id",    limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "price_id",    limit: 4
    t.date     "from",                                                  null: false
    t.date     "to",                                                    null: false
    t.integer  "amount",      limit: 4,                  default: 1,    null: false
    t.decimal  "total_price",             precision: 10
    t.decimal  "deposit",                 precision: 10
    t.decimal  "payment",                 precision: 10
    t.string   "name",        limit: 255
    t.string   "phone",       limit: 255
    t.boolean  "is_oneself",                             default: true
    t.string   "status",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["house_id"], name: "index_orders_on_house_id", using: :btree
  add_index "orders", ["price_id"], name: "index_orders_on_price_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "album_id",    limit: 4
    t.string   "title",       limit: 255
    t.string   "image",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree

  create_table "prices", force: :cascade do |t|
    t.integer  "house_id",   limit: 4
    t.decimal  "day",                  precision: 10
    t.date     "start"
    t.date     "end"
    t.decimal  "mon",                  precision: 10
    t.decimal  "tue",                  precision: 10
    t.decimal  "wed",                  precision: 10
    t.decimal  "thu",                  precision: 10
    t.decimal  "fri",                  precision: 10
    t.decimal  "sat",                  precision: 10
    t.decimal  "sun",                  precision: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prices", ["house_id"], name: "index_prices_on_house_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "province",    limit: 255
    t.string   "city",        limit: 255
    t.string   "zipcode",     limit: 255
    t.string   "address",     limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "schools", ["name"], name: "index_schools_on_name", unique: true, using: :btree

  create_table "task_scores", force: :cascade do |t|
    t.float    "score",      limit: 24
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "task_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "task_scores", ["task_id"], name: "index_task_scores_on_task_id", using: :btree
  add_index "task_scores", ["user_id"], name: "index_task_scores_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "status",      limit: 255
    t.integer  "position",    limit: 4
    t.text     "description", limit: 65535
    t.integer  "course_id",   limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "tasks", ["course_id"], name: "index_tasks_on_course_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "tid",         limit: 255
    t.string   "name",        limit: 255
    t.string   "grade",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "school_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "user_courses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_courses", ["course_id"], name: "index_user_courses_on_course_id", using: :btree
  add_index "user_courses", ["user_id"], name: "index_user_courses_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",               null: false
    t.string   "encrypted_password",     limit: 255, default: "",               null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,                null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "avatar",                 limit: 255
    t.boolean  "forem_admin",                        default: false
    t.string   "forem_state",            limit: 255, default: "pending_review"
    t.boolean  "forem_auto_subscribe",               default: false
    t.integer  "team_id",                limit: 4
    t.integer  "school_id",              limit: 4
    t.string   "realname",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
