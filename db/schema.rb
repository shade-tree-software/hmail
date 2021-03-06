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

ActiveRecord::Schema.define(version: 20160217011142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emails", force: :cascade do |t|
    t.string   "encrypted_body"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "archived"
    t.boolean  "sent"
    t.string   "encrypted_subject"
    t.string   "encrypted_recipients"
    t.string   "encrypted_sender"
    t.integer  "date"
    t.boolean  "unread"
    t.boolean  "deleted"
  end

  add_index "emails", ["user_id", "encrypted_subject", "encrypted_recipients", "encrypted_sender", "date"], name: "emails_user_id_subject_to_from_date_key", unique: true, using: :btree

  create_table "friends", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "queue_classic_jobs", id: :bigserial, force: :cascade do |t|
    t.text     "q_name",                       null: false
    t.text     "method",                       null: false
    t.json     "args",                         null: false
    t.datetime "locked_at"
    t.integer  "locked_by"
    t.datetime "created_at", default: "now()"
  end

  add_index "queue_classic_jobs", ["q_name", "id"], name: "idx_qc_on_name_only_unlocked", where: "(locked_at IS NULL)", using: :btree

  create_table "secondary_account_links", force: :cascade do |t|
    t.integer "primary_user_id"
    t.integer "secondary_user_id"
  end

  create_table "userfriends", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_email_pw"
    t.boolean  "admin",                  default: false
    t.boolean  "allow_unapproved",       default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
