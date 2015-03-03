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

ActiveRecord::Schema.define(version: 20150303160726) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer  "sport_id",   limit: 4
    t.string   "name",       limit: 255
    t.string   "team",       limit: 255
    t.string   "position",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "players", ["sport_id"], name: "index_players_on_sport_id", using: :btree

  create_table "prop_choices", force: :cascade do |t|
    t.integer  "prop_id",    limit: 4
    t.text     "choice",     limit: 65535
    t.integer  "odds",       limit: 4
    t.float    "score",      limit: 24
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "winner",     limit: 1,     default: false
    t.integer  "available",  limit: 4,     default: 0
  end

  add_index "prop_choices", ["prop_id"], name: "index_prop_choices_on_prop_id", using: :btree

  create_table "props", force: :cascade do |t|
    t.integer  "sport_id",    limit: 4
    t.datetime "time"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "state",       limit: 4,     default: 0
    t.text     "proposition", limit: 65535
    t.float    "opt1_spread", limit: 24
    t.float    "opt2_spread", limit: 24
  end

  add_index "props", ["sport_id"], name: "index_props_on_sport_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.integer  "sender_id",   limit: 4
    t.integer  "receiver_id", limit: 4
    t.integer  "amount",      limit: 4
    t.integer  "state",       limit: 4, default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255
    t.string   "address",                limit: 255
    t.string   "phone",                  limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "country",                limit: 255
    t.string   "zip",                    limit: 255
    t.integer  "role",                   limit: 4,   default: 1
    t.string   "name",                   limit: 255
    t.integer  "balance",                limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wagers", force: :cascade do |t|
    t.integer  "prop_id",        limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "state",          limit: 4,  default: 0
    t.integer  "risk",           limit: 4
    t.integer  "win",            limit: 4
    t.integer  "prop_choice_id", limit: 4
    t.integer  "odds",           limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.float    "spread",         limit: 24
    t.float    "total",          limit: 24
  end

  add_index "wagers", ["prop_id"], name: "index_wagers_on_prop_id", using: :btree
  add_index "wagers", ["user_id"], name: "index_wagers_on_user_id", using: :btree

end
