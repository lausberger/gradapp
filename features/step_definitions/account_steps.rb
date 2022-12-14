# frozen_string_literal: true

Given(/^I am on the account registration page$/) do
  visit register_path
end

def fill_out_form(email)
  fill_in 'account_first_name', with: 'Lucas'
  fill_in 'account_last_name', with: 'Ausberger'
  fill_in 'account_email', with: email
  fill_in 'account_password', with: 'password'
  fill_in 'account_password_confirmation', with: 'password'
end

When(/^I fill out the form with email "(.*?)" and (.*?)$/) do |email, option|
  fill_out_form email
  case option
  when '"Student" selected'
    select 'Student', from: 'account[account_type]'
  when '"Faculty" selected'
    select 'Faculty', from: 'account[account_type]'
  when 'non-matching passwords'
    fill_in 'account_password_confirmation', with: 'different password'
  when 'empty fields'
    fill_in 'account_last_name', with: ''
  else
    raise ArgumentError "Unrecognized option: \"#{option}\""
  end
end

And(/^I submit the form$/) do
  click_button 'Register'
end

Then(/^I should be redirected to the login page$/) do
  expect(page).to have_current_path(login_path)
end

And(/^I should see a notice that says "(.*?)"$/) do |notice|
  expect(page).to have_content(notice)
end
