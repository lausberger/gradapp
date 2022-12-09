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

When(/^I fill out the research area form with "(.*?)", "(.*?)", and "(.*?)"$/) do |title, summary, overview|
  fill_in 'Title', with: title
  fill_in 'Summary', with: summary
  fill_in 'Detailed Overview', with: overview
  click_button 'Add Area'
end

Then(/^I should be redirected to the research areas page$/) do
  expect(page).to have_current_path(research_areas_path)
end
