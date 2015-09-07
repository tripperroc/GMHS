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

ActiveRecord::Schema.define(version: 20150823014659) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "estimates", force: true do |t|
    t.integer  "response_id"
    t.integer  "facebook_male_friends"
    t.integer  "facebook_gay_friends"
    t.string   "accuracy"
    t.integer  "right_percentage"
    t.integer  "facebook_recruitable_friends"
    t.string   "accuracy_recruitable"
    t.integer  "right_percentage_recruitable"
    t.string   "how_recruited"
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook_friendships", force: true do |t|
    t.integer  "lower_facebook_user_id"
    t.integer  "higher_facebook_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_friendships", ["higher_facebook_user_id"], name: "index_facebook_friendships_on_higher_facebook_user_id"
  add_index "facebook_friendships", ["lower_facebook_user_id"], name: "index_facebook_friendships_on_lower_facebook_user_id"

  create_table "facebook_responses", force: true do |t|
    t.integer  "facebook_user_id"
    t.integer  "recruit_id"
    t.string   "recruitee_coupon"
    t.string   "recruiter_coupon"
    t.boolean  "eighteen_or_older"
    t.string   "orientation"
    t.string   "gender"
    t.string   "email_address"
    t.integer  "facebook_male_friends"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook_users", force: true do |t|
    t.integer  "so_facebook_user_id"
    t.integer  "facebook_account_number"
    t.string   "hashed_facebook_account_number"
    t.string   "gender"
    t.string   "interested_in"
    t.string   "name"
    t.string   "relationship_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_users", ["facebook_account_number"], name: "index_facebook_users_on_facebook_account_number"
  add_index "facebook_users", ["gender"], name: "index_facebook_users_on_gender"
  add_index "facebook_users", ["hashed_facebook_account_number"], name: "index_facebook_users_on_hashed_facebook_account_number"
  add_index "facebook_users", ["interested_in"], name: "index_facebook_users_on_interested_in"
  add_index "facebook_users", ["relationship_status"], name: "index_facebook_users_on_relationship_status"
  add_index "facebook_users", ["so_facebook_user_id"], name: "index_facebook_users_on_so_facebook_user_id"

  create_table "fronts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recruitee_coupon"
  end

  create_table "redssocs_survey_consents", force: true do |t|
    t.boolean  "eighteen_or_older"
    t.boolean  "read_and_understand"
    t.boolean  "dont_meet_all_criteria"
    t.string   "orientation"
    t.string   "gender"
    t.boolean  "facebook"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", force: true do |t|
    t.string   "facebook_response_id"
    t.string   "recruitee_coupon"
    t.string   "recruiter_coupon"
    t.string   "email_address"
    t.integer  "age"
    t.string   "birth_sex"
    t.string   "sexual_orientation"
    t.string   "hispanic"
    t.string   "healthcare_delayed"
    t.string   "hundred_cigarettes"
    t.string   "frequency_cigarettes"
    t.string   "worried"
    t.string   "depressed"
    t.string   "suicide"
    t.integer  "alcohol"
    t.integer  "facebook_gay_friends"
    t.integer  "screening_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

end
