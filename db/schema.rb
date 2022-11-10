ActiveRecord::Schema.define(version: 20221108224911) do

  create_table "accounts", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "type",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "discussions" do |t|
    t.string "title"
    t.string "body"
    t.string "author"
    t.integer "root_discussion_id", default: -1
  end

end
