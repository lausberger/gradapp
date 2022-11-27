# frozen_string_literal: true

Then(/^I should see a flash saying "(.*?)"$/) do |message|
  expect(page).to have_css('.message', text: message)
end
