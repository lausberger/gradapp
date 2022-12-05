# frozen_string_literal: true

# Migration to change author_id to account_id in discussions table
class ChangeAuthorIdToAccountId < ActiveRecord::Migration
  def change
    rename_column :discussions, :author_id, :account_id
  end
end
