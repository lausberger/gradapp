# frozen_string_literal: true

Given(/^I am on the Graduate Applications home page$/) do
  visit graduate_applications_path
end

Given(/^I am creating a new graduate application$/) do
  visit new_graduate_application_path
end

Given(/the following graduate applications have been submitted:/) do |application_table|
  application_table.hashes.each do |application|
    GraduateApplication.create!(application)
  end
end

Given(/^I fill in my name as "(.*?)" "(.*?)"$/) do |first, last|
  fill_in 'First Name:', with: first
  fill_in 'Last Name:', with: last
end

And(/^I fill in my email as "(.*?)" and my phone as "(.*?)"$/) do |email, phone|
  fill_in 'Email:', with: email
  fill_in 'Phone:', with: phone
end

And(/^the application's GPA is "(\d*[.]\d*)"$/) do |gpa|
  expect(page).to have_content gpa
end

And(/^the application's name is "(.*?)" "(.*?)"$/) do |first, last|
  expect(page).to have_content "#{first} #{last}"
end

When(/^I sort graduate applications based on "(.*?)"$/) do |_score|
  pending
end

When(/^I submit my graduate application$/) do
  click_on 'Submit'
end

When(/^I select to view "(.*?)" "(.*?)"'s graduate application$/) do |first, last|
  all('tr').each do |tr|
    if tr.has_content? "#{first} #{last}"
      tr.click_on 'View Application'
      break
    end
  end
end

Then(/^I should see the application status "(.*?)"$/) do |status|
  expect(page).to have_content status
end

Then(/^I should see "(.*?)"'s application before "(.*?)"'s$/) do |_higher_name, _lower_name|
  pending # TODO: Check if higher_name occurs before lower_name in applications table
end
