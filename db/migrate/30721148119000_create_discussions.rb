# frozen_string_literal: true

# Creates the discussion DB table
class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.string :body
      t.string :author
      t.string :root_discussion_id, default: -1

      t.timestamps null: false
    end
  end
end
