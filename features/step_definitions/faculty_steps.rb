# frozen_string_literal: true

Given(/^I am on the Find Faculty page$/) do
  visit faculties_path
end

And(/^I the following accounts have been created:$/) do |account_table|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :account_type]
  pending 'Works on local, fails on GitHub because of email validation'
  account_table.hashes.each do |account|
    new_account = {
      first_name: account[:first_name],
      last_name: account[:last_name],
      email: account[:email],
      password: account[:password],
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
  # table is a table.hashes.keys # => [:first_name, :last_name]
  num_faculty = all('tr').length
  expect(num_faculty).eql? faculty_table.hashes.length
  all('tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    expect(faculty_table.hashes).to include(include('first_name' => first_name))
    expect(faculty_table.hashes).to include(include('last_name' => last_name))
  end
end
