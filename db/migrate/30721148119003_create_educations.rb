# frozen_string_literal: true

# Creates the education table
class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_name
      t.string :major
      t.string :degree
      t.boolean :currently_attending
      t.date :start_date
      t.date :end_date
      t.float :gpa_value
      t.float :gpa_scale

      t.timestamps
    end
  end
end
