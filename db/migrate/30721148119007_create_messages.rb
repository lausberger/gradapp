# frozen_string_literal: true

# Creates the messages table
class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :to, null: false, foreign_key: { to_table: :account }
      t.references :from, null: false, foreign_key: { to_table: :account }
      t.string :to_email, null: false
      t.string :from_email, null: false
      t.string :subject
      t.string :body

      t.timestamps null: false
    end
  end
end
