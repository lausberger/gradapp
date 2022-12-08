# frozen_string_literal: true

# Makes
class AddResearchAreaTitleUniqueness < ActiveRecord::Migration
  def change
    add_index :research_areas, :title, unique: true
  end
end
