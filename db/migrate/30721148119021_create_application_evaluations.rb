# frozen_string_literal: true

# Create the application evaluations table
class CreateApplicationEvaluations < ActiveRecord::Migration
  def change
    create_table :application_evaluations do |t|
      t.integer :score
      t.string :comment

      t.timestamps
    end
  end
end
