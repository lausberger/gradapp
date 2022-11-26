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
  visit '/messages'
end

When('I have visited the send messages page') do
  visit '/messages/new'
end

When('I have logged in as {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I fill in the {string} with {string}') do |string, string2|
  fill_in string, :with => string2
end

When('I have clicked the button {string}') do |string|
  click_button(string)
end

