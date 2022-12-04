class ChangeAuthorToReferenceAccountInStudentDiscussions < ActiveRecord::Migration
  def change
    add_reference :discussions, :author, foreign_key: { to_table: :account }, :index => true
  end
end
