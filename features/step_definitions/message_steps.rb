# frozen_string_literal: true

Given('the following messages have been sent to John Doe:') do |messages_table|
  acc = Account.find_by(email: 'jdoe@gmail.com')
  messages_table.hashes.each do |message|
    message[:to_id] = acc.id
    Message.create!(message)
  end
end

Given('the following messages have been sent:') do |messages_table|
  messages_table.hashes.each do |message|
    Message.create!(message)
  end
end

Given('the following accounts have been added:') do |accounts_table|
  accounts_table.hashes.each do |account|
    Account.create!(account)
  end
end

When('I have visited the messages page') do
  visit messages_path
end

When('I have visited the send messages page') do
  visit messages_new_path
end

When('I have visited the replies page') do
  visit '/messages/reply.1'
end

When('I fill in the {string} with {string}') do |string, string2|
  fill_in string, with: string2
end

When('I have clicked the button {string}') do |string|
  click_button(string)
end

When('I have logged in as John Doe') do
  visit login_path
  fill_in 'Email', with: 'jdoe@gmail.com'
  fill_in 'Password', with: '12345678'
  click_button 'Log in'
end

When('I view the reply page for message {string}') do |string|
  visit("/messages/reply.#{string}")
end

When('pending') do
  pending
end
