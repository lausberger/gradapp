class ChangeAuthorIdToAccountId < ActiveRecord::Migration
  def change
    rename_column :discussions, :author_id, :account_id
  end
end
