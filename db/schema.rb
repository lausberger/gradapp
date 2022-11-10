ActiveRecord::Schema.define do

  create_table "discussions" do |t|
    t.string "title"
    t.string "body"
    t.string "author"
    t.integer "root_discussion_id", default: -1
  end
end
