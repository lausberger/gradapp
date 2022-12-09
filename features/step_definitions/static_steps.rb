# frozen_string_literal: true

When('I have visited the GradApp Home Page') do
  visit home_path
end

When('I have clicked {string}') do |string|
  click_on string
end

When('I go to the url {string}') do |string|
  visit string
end

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end
