# frozen_string_literal: true

# Fix missing declaration of uniqueness in email column for original accounts table creation
class MakeAccountsEmailUnique < ActiveRecord::Migration
  def change
    add_index :accounts, :email, unique: true
  end
end
