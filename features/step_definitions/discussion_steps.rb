# frozen_string_literal: true

Given(/^I am on the discussions page$/) do
  visit discussions_path
end

When(/^I post a reply with body "([^"]*)"$/) do |body|
  fill_in('Body', with: body)
  click_button(id: 'post_reply_button')
end

When(/^I click on "([^"]*)" button for post with(?: title "([^"]*)")? body "([^"]*)" and author "([^"]*)"$/) do |button_name, title, body, author|
  all('#main tr').each do |row|
    items = row.all('td')
    if !title.nil?
      log(items[0].text)
      if items[0].text == title && items[1].text == body && items[2].text == author
        expect(row).to have_css('a', text: button_name)
        row.find('a', text: button_name).click
      end
    elsif items[0].text == body && items[1].text == author
      expect(row).to have_css('a', text: button_name)
      row.find('a', text: button_name).click
    end
  end
  if button_name == 'Edit'
    expect(find('#discussion_edit_title').text).to eq 'Edit Discussion Post'
  end
end

When(/^I post a new discussion with title "([^"]*)" and body "([^"]*)"$/) do |title, body|
  find('a', text: 'Post new Discussion').click
  fill_in('Title', with: title)
  fill_in('Body', with: body)
  click_button(id: 'post_discussion_button')
end

And(/^I have added a discussion with title "([^"]*)" and body "([^"]*)" and author "([^"]*)"$/) do |title, body, author|
  names = author.split(/ /)
  account = Account.find_by(first_name: names[0])
  discussion = {
    title: title,
    body: body,
    account_id: account.id
  }
  Discussion.create discussion
end

And(/^There is reply to discussion post with title "([^"]*)" and body "([^"]*)" with body "([^"]*)" by "([^"]*)"$/) do
                                                                      |root_title, _root_body, reply_body, reply_author|
  names = reply_author.split(/ /)
  account = Account.find_by(first_name: names[0])
  root_discussion = Discussion.find_by(title: root_title)
  reply_discussion = {
    title: '',
    body: reply_body,
    account_id: account.id,
    root_discussion_id: root_discussion.id
  }
  Discussion.create reply_discussion
end

And(/^I see a button called "([^"]*)"$/) do |button_name|
  expect(page).to have_css("##{button_name.gsub(/ /, '_').downcase}_button")
end

And(/^I am on the reply page for post title "([^"]*)" and body "([^"]*)" and author "([^"]*)"$/) do |title, body, author|
  visit discussions_path
  all('#main tr').each do |row|
    items = row.all('td')
    if (items[0].text == title) && (items[1].text == body) && (items[2].text == author)
      row.find('a', text: 'View Replies').click
      break
    end
  end
  expect(find('#discussion_title').text).to eq title
end

And(/^I change the(?: title to "([^"]*)" and)? body to "([^"]*)"$/) do |title, body|
  unless title.nil?
    fill_in('Title', with: title)
  end
  fill_in('Body', with: body)
  click_button(id: 'edit_discussion_post')
end

Then(/^I should not see a button called "([^"]*)"$/) do |button_name|
  expect(page).not_to have_css('a', text: button_name)
end

Then(/^I should not see any "([^"]*)" buttons$/) do |button_name|
  all('#main tr').each do |row|
    expect(row).not_to have_css('a', text: button_name)
  end
end

Then(/^I should see a discussion post with(?: title "([^"]*)" and)? body "([^"]*)" and author "([^"]*)"$/) do |title, body, author|
  all('#main tr').each do |row|
    items = row.all('td')
    if title.nil?
      expect(items[0].text).to eq body
      expect(items[1].text).to eq author
    else
      expect(items[0].text).to eq title
      expect(items[1].text).to eq body
      expect(items[2].text).to eq author
    end
  end
end

Then(/^I should not see a discussion post with(?: title "([^"]*)" and)? body "([^"]*)" and author "([^"]*)"$/) do |title, body, author|
  all('#main tr').each do |row|
    items = row.all('td')
    if title.nil?
      expect(items[0].text).not_to eq body
      expect(items[1].text).not_to eq author
    else
      expect(items[0].text).not_to eq title
      expect(items[1].text).not_to eq body
      expect(items[2].text).not_to eq author
    end
  end
end
