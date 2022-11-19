Given(/^I am on the Find Faculty page$/) do
  visit facultys_path
end

And(/^I the following accounts have been created:$/) do |account_table|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :account_type]
  account_table.hashes.each do |account|
    new_account = {
      :first_name => account[:first_name],
      :last_name => account[:last_name],
      :email => account[:email],
      :password => account[:password],
      :account_type => account[:account_type],
    }
    Account.create!(new_account)
  end
end

And(/^I the following faculty member accounts have been created:$/) do |faculty_table|
  # table is a table.hashes.keys # => [:account_id, :topic_area]
  faculty_table.hashes.each do |faculty|
    new_faculty = {
      :account_id => faculty[:account_id],
      :topic_area => faculty[:topic_area]
    }
    Faculty.create!(new_faculty)
  end
end

And(/^I search for "([^"]*)" topic area$/) do |topic_area|
  fill_in('search_topic_area', :with => topic_area)
  click_button("search_topic_area_button")
end

Then(/^I should see Faculty Members:$/) do |faculty_table|
  # table is a table.hashes.keys # => [:first_name, :last_name]
  num_faculty = all("tr").length
  expect(num_faculty).eql? faculty_table.hashes.length
  all("tr").each do |row|
    first_name = row.all("td")[0].text
    last_name = row.all('td')[1].text
    expect(faculty_table.hashes).to include(include('first_name' => first_name))
    expect(faculty_table.hashes).to include(include('last_name' => last_name))
  end
end
