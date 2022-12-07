# frozen_string_literal: true

# Migration to add Students Table referencing account
class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
