class AddSessionTokenToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :session_token, :string
    add_index :accounts, :session_token
  end
end
