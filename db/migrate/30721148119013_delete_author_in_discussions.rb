class DeleteAuthorInDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :author
  end
end
