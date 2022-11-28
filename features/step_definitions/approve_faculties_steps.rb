# frozen_string_literal: true

Given(/^I am on the approve faculty accounts page$/) do
  visit approve_faculties_path
end

And(/^There are the following accounts created:$/) do |accounts|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :account_type, :topic_area]
  accounts.hashes.each do |account|
    account_creation = Account.create!(first_name: account[:first_name], last_name: account[:last_name], email: account[:email],
                                       password: account[:password], account_type: account[:account_type])
    next if account[:topic_area].empty?

    Faculty.create!(account_id: account_creation.id, topic_area: account[:topic_area])
  end
end

When(/^I approve the following faculty account:$/) do |accounts|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :account_type, :topic_area]
  accounts.hashes.each do |account|
    faculty = Faculty.find_by(account_id: Account.find_by(first_name: account[:first_name]).id)
    faculty.update(approved: true)
  end
end

Then(/^I should see the following faculty accounts:$/) do |accounts|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :account_type, :topic_area]
  num_faculty = all('tr').length
  expect(num_faculty).eql? accounts.hashes.length
  all('tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    topic_area = row.all('td')[2].text
    expect(accounts.hashes).to include(include('first_name' => first_name))
    expect(accounts.hashes).to include(include('last_name' => last_name))
    expect(accounts.hashes).to include(include('topic_area' => topic_area))
  end
end

Then(/^I should no long see the following account:$/) do |accounts|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :account_type, :topic_area]
  all('tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    topic_area = row.all('td')[2].text
    expect(accounts.hashes).not_to include(include('first_name' => first_name))
    expect(accounts.hashes).not_to include(include('last_name' => last_name))
    expect(accounts.hashes).not_to include(include('topic_area' => topic_area))
  end
end
