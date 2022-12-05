# frozen_string_literal: true

# Migration to add author_id column referencing account_id
class ChangeAuthorToReferenceAccountInStudentDiscussions < ActiveRecord::Migration
  def change
    add_reference :discussions, :author, foreign_key: { to_table: :account }, index: true
  end
end
