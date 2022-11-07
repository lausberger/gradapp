Given(/^I have added a discussion with the title "([^"]*)" and body "([^"]*)" and author "([^"]*)"$/) do |title, body, author|
  pending
  # TODO Create root discussion post
end

Given(/^There is a reply with body "([^"]*)" authored by "([^"]*)"$/) do |body, author|
  pending
  # TODO Create root discussion post with reply
end

Given(/^I am on the discussion page with the title "([^"]*)" and authored by "([^"]*)"$/) do |title, author|
  expected_page_title = "#{title} - #{author}"
  all("tr").each do |tr|
    post_title = tr.all("td")[0].text
    post_author = tr.all("td")[2].text
    if post_title.eql? title and post_author.eql? author
      tr.all("td")[3].click_link
      break
    end
  end
  page_title = page.title
  expect(page_title).eql? expected_page_title
end

When(/^I am on the discussions home page$/) do
  visit discussions_path
end

When(/^I post a reply with body "([^"]*)" and authored by "([^"]*)"$/) do |body, author|
  pending
end

When(/^I have deleted the discussion with the title "([^"]*)" authored by "([^"]*)"$/) do |title, author|
  pending
end

When(/^I edit the discussion titled "([^"]*)" by "([^"]*)" with title "([^"]*)" and body "([^"]*)"$/) do |old_title, author, new_title, new_body|
  pending
end

When(/^I edit discussion reply with body "([^"]*)" authored by "([^"]*)" to body "([^"]*)"$/) do |old_body, author, new_body|
  pending
end

Then(/^I should see the discussion post by "([^"]*)"$/) do |author|
  expect(find_post_by_author(author)).to be_truthy
end

Then(/^I should see a reply with body "([^"]*)" and authored by "([^"]*)"$/) do |body, author|
  found_post = false
  all("tr").each do |tr|
    post_body = tr.all("td")[1].text
    post_author = tr.all("td")[2].text
    if post_body.eql? body and post_author.eql? author
      found_post = true
      break
    end
  end
  expect(found_post).to be_truthy
end

Then(/^I should not see the discussion post by "([^"]*)"$/) do |author|
  expect(find_post_by_author(author)).to be_falsey
end

Then(/^I should be redirected to the discussion homepage$/) do
  page_title = page.title
  expected_page_title = "Student Discussions"
  expect(page_title).eql? expected_page_title
end

Then(/^I should be redirected to the discussion page for the discussion with title "([^"]*)" authored by "([^"]*)"$/) do |title, author|
  page_title = page.title
  expected_page_title = "#{title} - #{author}"
  expect(page_title).eql? expected_page_title
end

Then(/^I should see the discussion post by "([^"]*)" with title "([^"]*)" and body "([^"]*)"$/) do |author, title, body|
  found_post = false
  all("tr").each do |tr|
    post_title = tr.all("td")[0].text
    post_body = tr.all("td")[1].text
    post_author = tr.all("td")[2].text
    if post_title.eql? title and post_body.eql? body and post_author.eql? author
      found_post = true
      break
    end
  end
  expect(found_post).to be_truthy
end

def find_post_by_author author
  found_author = false
  all("tr").each do |tr|
    post_author = tr.all("td")[2].text
    if post_author.eql? author
      found_author = true
      break
    end
  end
  found_author
end
