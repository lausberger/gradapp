# frozen_string_literal: true

# Creates the account DB table
class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
