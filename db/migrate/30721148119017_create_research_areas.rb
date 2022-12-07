# frozen_string_literal: true

# Creates the research_area DB table
class CreateResearchAreas < ActiveRecord::Migration
  def change
    create_table :research_areas do |t|
      t.string :title, null: false
      t.string :overview, null: false

      t.timestamps null: false
    end
  end
end
