Given(/^I have added a discussion with the title "([^"]*)" and body "([^"]*)" and author "([^"]*)"$/) do |arg1, arg2, arg3|
  pending
end

Given(/^There is a reply with body "([^"]*)" authored by "([^"]*)"$/) do |arg1, arg2|
  pending
end

Given(/^I am on the discussion page with the title "([^"]*)" and authored by "([^"]*)"$/) do |arg1, arg2|
  pending
end

When(/^I am on the discussions home page$/) do
  visit discussions_path
end

When(/^I post a reply with body "([^"]*)" and authored by "([^"]*)"$/) do |arg1, arg2|
  pending
end

When(/^I have deleted the discussion with the title "([^"]*)" authored by "([^"]*)"$/) do |arg1, arg2|
  pending
end

When(/^I edit the discussion titled "([^"]*)" by "([^"]*)" with title "([^"]*)" and body "([^"]*)"$/) do |arg1, arg2, arg3, arg4|
  pending
end

When(/^I edit discussion reply with body "([^"]*)" authored by "([^"]*)" to body "([^"]*)"$/) do |arg1, arg2, arg3|
  pending
end

Then(/^I should see the discussion post by "([^"]*)"$/) do |name|\
  found_author = false
  all("tr").each do |tr|
    author = tr.all("td")[2].text
    if author.eql? name
      found_author = true
      break
    end
  end
  expect(found_author).to be_truthy
end

Then(/^I should see a reply with body "([^"]*)" and authored by "([^"]*)"$/) do |body, author|
  found_post = false
  all("tr").each do |tr|
    post_body = tr.all("td")[1].test
    post_author = tr.all("td")[2].text
    if post_body.eql? body and post_author.eql? author
      found_post = true
      break
    end
  end
  expect(found_post).to be_truthy
  pending
end

Then(/^I should not see the discussion post by "([^"]*)"$/) do |arg|
  pending
end

Then(/^I should be redirected to the discussion homepage$/) do
  pending
end

Then(/^I should be redirected to the discussion page for the discussion with title "([^"]*)" authored by "([^"]*)"$/) do |arg1, arg2|
  pending
end

Then(/^I should see the discussion post by "([^"]*)" with title "([^"]*)" and body "([^"]*)"$/) do |arg1, arg2, arg3|
  pending
end
