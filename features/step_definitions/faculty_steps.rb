# frozen_string_literal: true

Given(/^I am on the Find Faculty page$/) do
  visit faculties_path
end

Given(/^The following accounts have been created:$/) do |account_table|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :password_confirmation, :account_type]
  account_table.hashes.each do |account|
    new_account = {
      first_name: account[:first_name],
      last_name: account[:last_name],
      email: account[:email],
      password: account[:password],
      password_confirmation: account[:password_confirmation],
      account_type: account[:account_type]
    }
    account_creation = Account.create!(new_account)
    next if account[:topic_area].empty?

    faculty = {
      account_id: account_creation.id,
      topic_area: account[:topic_area]
    }
    Faculty.create!(faculty)
  end
end

And(/^I search for "([^"]*)" topic area$/) do |topic_area|
  fill_in('search_topic_area', with: topic_area)
  click_button('search_topic_area_button')
end

Then(/^I should see Faculty Members:$/) do |faculty_table|
  # table is a table.hashes.keys # => [:first_name, :last_name, :topic_area]
  num_faculty = all('tbody tr').length
  expect(num_faculty).eql? faculty_table.hashes.length
  # needed for implementation detail where filtering by topic area produces different table rows
  expect_topic_area = faculty_table.hashes[0].keys.length == 3
  all('tbody tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    if expect_topic_area
      topic_area = row.all('td')[2].text
      expected_hashes = { 'first_name' => first_name, 'last_name' => last_name, 'topic_area' => topic_area }
    else
      expected_hashes = { 'first_name' => first_name, 'last_name' => last_name }
    end
    expect(faculty_table.hashes).to include(expected_hashes)
  end
end
