# frozen_string_literal: true

Given(/^I have created an account$/) do
  @my_account = Account.create!(
    first_name: 'Test',
    last_name: 'Student',
    email: 'testyguy@yahoo.com',
    password: 'testyspw99',
    password_confirmation: 'testyspw99',
    account_type: 'Student',
    )
end
Given(/^I have created a student account$/) do
  @my_account = Account.create!(
    first_name: 'Test',
    last_name: 'Student',
    email: 'test-student@uiowa.edu',
    password: 'password',
    password_confirmation: 'password',
    account_type: 'Student',
    )
end

Given(/^I have created a faculty account$/) do
  @my_account = Account.create!(
    first_name: 'Test',
    last_name: 'Faculty',
    email: 'test-faculty@uiowa.edu',
    password: 'password',
    password_confirmation: 'password',
    account_type: 'Faculty'
  )
end

Given(/^I have created a department chair account$/) do
  @my_account = Account.create!(
    first_name: 'Test',
    last_name: 'Chair',
    email: 'test-chair@uiowa.edu',
    password: 'password',
    password_confirmation: 'password',
    account_type: 'Chair'
  )
end

Given(/^I am signed in to my account$/) do
  visit login_path
  fill_in 'Email', with: @my_account.email
  fill_in 'Password', with: @my_account.password
  click_button 'Log in'
end

Given(/^I am on the login page$/) do
  visit login_path
end

When(/^I submit the form with (.+?) email and (.+?) password$/) do |email_type, password_type|
  email = email_type == 'good' ? 'testyguy@yahoo.com' : 'nottesty@fake.com'
  password = password_type == 'good' ? 'testyspw99' : 'spellingmistake'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end

And(/^I should see a notice that says "(.+?)" followed by my first name$/) do |notice|
  expect(page).to have_content("#{notice}#{@my_account.first_name}.")
end

Then(/^I should not be redirected$/) do
  expect(page).to have_current_path(login_path)
end

And(/^I should see a warning that says "(.*?)"$/) do |notice|
  expect(page).to have_content(notice)
end

Given(/^I have logged out$/) do
  visit profile_path
  click_on 'Log out'
end

When(/^I attempt to visit the profile page$/) do
  visit profile_path
end

Then(/^I should be redirected to the login page$/) do
  expect(page).to have_current_path(login_path)
end
