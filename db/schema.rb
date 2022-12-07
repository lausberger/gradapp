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

ActiveRecord::Schema.define(version: 30721148119018) do

  create_table "accounts", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "account_type",    null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true

  create_table "discussions", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.string   "root_discussion_id", default: "-1"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "account_id"
  end

  add_index "discussions", ["account_id"], name: "index_discussions_on_account_id"

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

  create_table "faculties", force: :cascade do |t|
    t.integer  "account_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "approved",         default: false
    t.integer  "research_area_id"
  end

  add_index "faculties", ["account_id"], name: "index_faculties_on_account_id"
  add_index "faculties", ["research_area_id"], name: "index_faculties_on_research_area_id"

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
    t.integer  "to_id",       null: false
    t.integer  "from_id",     null: false
    t.string   "to_email",    null: false
    t.string   "from_email",  null: false
    t.string   "subject"
    t.string   "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "messages_id"
  end

  create_table "research_areas", force: :cascade do |t|
    t.string   "title",             null: false
    t.string   "detailed_overview", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "summary"
  end

  create_table "student_checklists", force: :cascade do |t|
    t.boolean  "citizenship",            default: false
    t.boolean  "research_area",          default: false
    t.boolean  "degree_objective",       default: false
    t.boolean  "ug_inst",                default: false
    t.boolean  "ug_gpa",                 default: false
    t.boolean  "ug_degree",              default: false
    t.boolean  "ug_major",               default: false
    t.boolean  "ug_transcript",          default: false
    t.boolean  "grad_inst",              default: false
    t.boolean  "grad_gpa",               default: false
    t.boolean  "grad_degree",            default: false
    t.boolean  "grad_major",             default: false
    t.boolean  "grad_transcript",        default: false
    t.boolean  "letter_recommendations", default: false
    t.boolean  "gre_scores",             default: false
    t.boolean  "language_scores",        default: false
    t.boolean  "resume",                 default: false
    t.boolean  "sop",                    default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "account_id"
  end

  add_index "student_checklists", ["account_id"], name: "index_student_checklists_on_account_id"

  create_table "students", force: :cascade do |t|
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "students", ["account_id"], name: "index_students_on_account_id"

end
