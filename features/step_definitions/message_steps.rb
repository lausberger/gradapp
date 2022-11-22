Given('the following messages have been sent:') do |messages_table|
  messages_table.each do |message|
    Message.create!(message)
  end
end

When('I have visited the messages page') do
  visit '/messages'
end

When('I have logged in as {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I have clicked the button {string}') do |string|
  click_button(string)
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
