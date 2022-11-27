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

ActiveRecord::Schema.define(version: 30721148119005) do

  create_table "accounts", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "type",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true

  create_table "discussions", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.string   "author"
    t.string   "root_discussion_id", default: "-1"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "graduate_application_id"
    t.string   "name"
    t.string   "description"
    t.string   "file_ref"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "educations", force: :cascade do |t|
    t.integer  "graduate_application_id"
    t.string   "school_name"
    t.string   "major"
    t.string   "degree"
    t.boolean  "currently_attending"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "gpa_value"
    t.float    "gpa_scale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graduate_applications", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "dob"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "to_id",      null: false
    t.integer  "from_id",    null: false
    t.string   "to_email",   null: false
    t.string   "from_email", null: false
    t.string   "subject"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
