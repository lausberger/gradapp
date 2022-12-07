# frozen_string_literal: true

# Changes faculty and research_areas to allow linking
class AddResearchAreaLinking < ActiveRecord::Migration
  def change
    remove_column :faculties, :topic_area
    add_reference :faculties, :research_area, foreign_key: { to_table: :research_areas }, index: true
    rename_column :research_areas, :overview, :detailed_overview
    add_column :research_areas, :summary, :string
  end
end
