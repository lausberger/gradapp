Given(/^I have added a discussion with the title "([^"]*)" and body "([^"]*)" and author "([^"]*)"$/) do |title, body, author|
  click_on(:id => 'post_new_discussion')
  fill_in("Title", with: title)
  fill_in("Body", with: body)
  fill_in("Author", with: author)
  click_button(:id => 'post_discussion_button')
end

Given(/^There is a reply with body "([^"]*)" authored by "([^"]*)"$/) do |body, author|
  root_discussion = Discussion.create!(:title => "Main Post", :body => "Body", :author => "Admin", :root_discussion_id => 0)
  Discussion.create!(:title => "", :body => body, :author => author, :root_discussion_id => root_discussion.id)
end

Given(/^I am on the discussion page with the title "([^"]*)" and authored by "([^"]*)"$/) do |title, author|
  all("tr").each do |tr|
    post_title = tr.all("td")[0].text
    post_author = tr.all("td")[2].text
    if post_title.eql? title and post_author.eql? author
      tr.all("td")[5].click
    end
  end
end

When(/^I am on the discussions home page$/) do
  visit discussions_path
end


When(/^I post a reply with body "([^"]*)" and authored by "([^"]*)"$/) do |post_body, post_author|
  fill_in("body", with:post_body)
  fill_in("author", with: post_author)
  click_button(:id => 'post_reply_button')
end

When(/^I have deleted the discussion with the title "([^"]*)" authored by "([^"]*)"$/) do |post_title, post_author|
  all('tr').each do |tr|
    title = tr.all('td')[0].text
    author = tr.all('td')[2].text
    if title.eql? post_title and author.eql? post_author
      tr.find('a', :text => 'Delete').click
    end
  end
end

When(/^I have deleted the discussion reply with the body "([^"]*)" authored by "([^"]*)"$/) do |reply_body, reply_author|
  all('tr').each do |tr|
    body = tr.all('td')[0].text
    author = tr.all('td')[1].text
    if body.eql? reply_body and author.eql? reply_author
      tr.all("td")[3].click
    end
  end
end

When(/^I edit the discussion titled "([^"]*)" by "([^"]*)" with title "([^"]*)" and body "([^"]*)"$/) do |old_title, post_author, new_title, new_body|
  discussion = Discussion.find_by(title: old_title, author: post_author)
  discussion[:title] = new_title
  discussion[:body] = new_body
  discussion.save
end

When(/^I edit discussion reply with body "([^"]*)" authored by "([^"]*)" to body "([^"]*)"$/) do |old_body, post_author, new_body|
  discussion = Discussion.find_by(title: "", body: old_body, author: post_author)
  discussion[:body] = new_body
  discussion.save
end

Then(/^I should see the discussion post by "([^"]*)"$/) do |author|
  expect(find_post_by_author(author)).to be_truthy
end

Then(/^I should see a reply with body "([^"]*)" and authored by "([^"]*)"$/) do |body, author|
  found_post = false
  all("tr").each do |tr|
    post_body = tr.all("td")[0].text
    post_author = tr.all("td")[1].text
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

def find_post_by_author(author)
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
