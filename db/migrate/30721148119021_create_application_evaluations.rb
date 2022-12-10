# frozen_string_literal: true

# Create the application evaluations table
class CreateApplicationEvaluations < ActiveRecord::Migration
  def change
    create_table :application_evaluations do |t|
      t.references :graduate_application
      t.references :account
      t.integer :score
      t.string :comment

      t.timestamps
    end
  end
end
