# frozen_string_literal: true

Given(/^The following research areas have been created:$/) do |research_area_table|
  # table is a table.hashes.keys # => [:title, :summary, :detailed_overview]
  research_area_table.hashes.each do |research_area|
    new_research_area = {
      title: research_area[:title],
      summary: research_area[:summary],
      detailed_overview: research_area[:detailed_overview]
    }

    ResearchArea.create!(new_research_area)
  end
end
