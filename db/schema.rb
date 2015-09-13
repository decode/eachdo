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

ActiveRecord::Schema.define(version: 20150908155957) do

  create_table "albums", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id"
  end

  add_index "albums", ["house_id"], name: "index_albums_on_house_id"
  add_index "albums", ["user_id"], name: "index_albums_on_user_id"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "provider",     null: false
    t.string   "uid",          null: false
    t.string   "access_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "cid"
    t.string   "name"
    t.string   "term"
    t.string   "status"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "school_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "courses", ["cid"], name: "index_courses_on_cid", unique: true

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "house_id"
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "comment"
    t.decimal  "rating"
    t.string   "judgement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["house_id"], name: "index_feedbacks_on_house_id"
  add_index "feedbacks", ["order_id"], name: "index_feedbacks_on_order_id"
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id"

  create_table "forem_categories", force: :cascade do |t|
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "position",   default: 0
  end

  add_index "forem_categories", ["slug"], name: "index_forem_categories_on_slug", unique: true

  create_table "forem_forums", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count", default: 0
    t.string  "slug"
    t.integer "position",    default: 0
  end

  add_index "forem_forums", ["slug"], name: "index_forem_forums_on_slug", unique: true

  create_table "forem_groups", force: :cascade do |t|
    t.string "name"
  end

  add_index "forem_groups", ["name"], name: "index_forem_groups_on_name"

  create_table "forem_memberships", force: :cascade do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], name: "index_forem_memberships_on_group_id"

  create_table "forem_moderator_groups", force: :cascade do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], name: "index_forem_moderator_groups_on_forum_id"

  create_table "forem_posts", force: :cascade do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to_id"
    t.string   "state",       default: "pending_review"
    t.boolean  "notified",    default: false
  end

  add_index "forem_posts", ["reply_to_id"], name: "index_forem_posts_on_reply_to_id"
  add_index "forem_posts", ["state"], name: "index_forem_posts_on_state"
  add_index "forem_posts", ["topic_id"], name: "index_forem_posts_on_topic_id"
  add_index "forem_posts", ["user_id"], name: "index_forem_posts_on_user_id"

  create_table "forem_subscriptions", force: :cascade do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", force: :cascade do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",       default: false,            null: false
    t.boolean  "pinned",       default: false
    t.boolean  "hidden",       default: false
    t.datetime "last_post_at"
    t.string   "state",        default: "pending_review"
    t.integer  "views_count",  default: 0
    t.string   "slug"
  end

  add_index "forem_topics", ["forum_id"], name: "index_forem_topics_on_forum_id"
  add_index "forem_topics", ["slug"], name: "index_forem_topics_on_slug", unique: true
  add_index "forem_topics", ["state"], name: "index_forem_topics_on_state"
  add_index "forem_topics", ["user_id"], name: "index_forem_topics_on_user_id"

  create_table "forem_views", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             default: 0
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], name: "index_forem_views_on_updated_at"
  add_index "forem_views", ["user_id"], name: "index_forem_views_on_user_id"
  add_index "forem_views", ["viewable_id"], name: "index_forem_views_on_viewable_id"

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.time     "accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", force: :cascade do |t|
    t.string   "identifier"
    t.string   "name"
    t.string   "region"
    t.string   "province"
    t.string   "city"
    t.string   "district"
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
    t.integer  "amount"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geo_address"
  end

  add_index "houses", ["user_id"], name: "index_houses_on_user_id"

  create_table "information", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "login_count"
    t.string   "rank"
    t.decimal  "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "information", ["user_id"], name: "index_information_on_user_id"

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
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

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"

  create_table "mailboxer_receipts", force: :cascade do |t|
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

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "house_id"
    t.integer  "user_id"
    t.integer  "price_id"
    t.date     "from",                       null: false
    t.date     "to",                         null: false
    t.integer  "amount",      default: 1,    null: false
    t.decimal  "total_price"
    t.decimal  "deposit"
    t.decimal  "payment"
    t.string   "name"
    t.string   "phone"
    t.boolean  "is_oneself",  default: true
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["house_id"], name: "index_orders_on_house_id"
  add_index "orders", ["price_id"], name: "index_orders_on_price_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "photos", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "title"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id"

  create_table "prices", force: :cascade do |t|
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

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "province"
    t.string   "city"
    t.string   "zipcode"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schools", ["name"], name: "index_schools_on_name", unique: true

  create_table "task_scores", force: :cascade do |t|
    t.float    "score"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "task_scores", ["task_id"], name: "index_task_scores_on_task_id"
  add_index "task_scores", ["user_id"], name: "index_task_scores_on_user_id"

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.string   "status"
    t.integer  "position"
    t.text     "description"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tasks", ["course_id"], name: "index_tasks_on_course_id"
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

  create_table "teams", force: :cascade do |t|
    t.string   "tid"
    t.string   "name"
    t.string   "grade"
    t.text     "description"
    t.integer  "school_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_courses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_courses", ["course_id"], name: "index_user_courses_on_course_id"
  add_index "user_courses", ["user_id"], name: "index_user_courses_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",               null: false
    t.string   "encrypted_password",     default: "",               null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                null: false
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
    t.string   "avatar"
    t.boolean  "forem_admin",            default: false
    t.string   "forem_state",            default: "pending_review"
    t.boolean  "forem_auto_subscribe",   default: false
    t.integer  "team_id"
    t.integer  "school_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
