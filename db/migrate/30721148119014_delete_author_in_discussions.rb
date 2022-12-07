# frozen_string_literal: true

# Migration to delete old author column
class DeleteAuthorInDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :author
  end
end
