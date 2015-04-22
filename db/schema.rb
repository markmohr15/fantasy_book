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

ActiveRecord::Schema.define(version: 20150422160311) do

  create_table "affiliate_payments", force: :cascade do |t|
    t.integer  "amount",       limit: 4
    t.integer  "state",        limit: 4, default: 0
    t.integer  "affiliate_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "affiliate_payments", ["affiliate_id"], name: "index_affiliate_payments_on_affiliate_id", using: :btree
  add_index "affiliate_payments", ["user_id"], name: "index_affiliate_payments_on_user_id", using: :btree

  create_table "bonus_codes", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.integer  "percentage", limit: 4
    t.integer  "rollover",   limit: 4
    t.string   "note",       limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "maximum",    limit: 4,   default: 20000
    t.boolean  "enabled",    limit: 1,   default: true
    t.boolean  "one_time",   limit: 1,   default: true
    t.integer  "length",     limit: 4
  end

  create_table "bonuses", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "amount",         limit: 4
    t.integer  "pending",        limit: 4
    t.integer  "rollover",       limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "state",          limit: 4
    t.integer  "released",       limit: 4, default: 0
    t.integer  "bonus_code_id",  limit: 4
    t.date     "exp_date"
    t.integer  "delayed_job_id", limit: 4
  end

  add_index "bonuses", ["bonus_code_id"], name: "index_bonuses_on_bonus_code_id", using: :btree
  add_index "bonuses", ["user_id"], name: "index_bonuses_on_user_id", using: :btree

  create_table "credits", force: :cascade do |t|
    t.integer  "admin_id",   limit: 4
    t.integer  "amount",     limit: 4
    t.string   "note",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "credits", ["admin_id"], name: "index_credits_on_admin_id", using: :btree
  add_index "credits", ["user_id"], name: "index_credits_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "deposits", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "amount",     limit: 4
    t.string   "kind",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "bonus_code", limit: 255
    t.string   "stripe_id",  limit: 255
  end

  add_index "deposits", ["user_id"], name: "index_deposits_on_user_id", using: :btree

  create_table "mass_emails", force: :cascade do |t|
    t.text     "message",        limit: 65535
    t.string   "subject",        limit: 255
    t.integer  "group",          limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "send_at"
    t.integer  "delayed_job_id", limit: 4
  end

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
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "available",  limit: 4,     default: 0
  end

  add_index "prop_choices", ["prop_id"], name: "index_prop_choices_on_prop_id", using: :btree

  create_table "props", force: :cascade do |t|
    t.integer  "sport_id",       limit: 4
    t.datetime "time"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "state",          limit: 4,     default: 0
    t.text     "proposition",    limit: 65535
    t.float    "opt1_spread",    limit: 24
    t.float    "opt2_spread",    limit: 24
    t.integer  "winner",         limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "delayed_job_id", limit: 4
  end

  add_index "props", ["sport_id"], name: "index_props_on_sport_id", using: :btree
  add_index "props", ["user_id"], name: "index_props_on_user_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "texts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.integer  "sender_id",   limit: 4
    t.integer  "receiver_id", limit: 4
    t.integer  "amount",      limit: 4
    t.integer  "state",       limit: 4, default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "transfers", ["receiver_id"], name: "index_transfers_on_receiver_id", using: :btree
  add_index "transfers", ["sender_id"], name: "index_transfers_on_sender_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
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
    t.boolean  "email_notif",            limit: 1,   default: true
    t.boolean  "sms_notif",              limit: 1,   default: false
    t.string   "referral_code",          limit: 255
    t.boolean  "affiliate",              limit: 1,   default: false
    t.string   "stripe_customer_id",     limit: 255
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
  end

  add_index "wagers", ["prop_choice_id"], name: "index_wagers_on_prop_choice_id", using: :btree
  add_index "wagers", ["prop_id"], name: "index_wagers_on_prop_id", using: :btree
  add_index "wagers", ["user_id"], name: "index_wagers_on_user_id", using: :btree

  create_table "withdrawals", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "amount",     limit: 4
    t.string   "kind",       limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "state",      limit: 4,   default: 0
    t.integer  "fee",        limit: 4
  end

  add_index "withdrawals", ["user_id"], name: "index_withdrawals_on_user_id", using: :btree

end
