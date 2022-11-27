# frozen_string_literal: true

# Active Record Account column rename
class RenameTypeToAccountType < ActiveRecord::Migration
  def change
    rename_column :accounts, :type, :account_type
  end
end
