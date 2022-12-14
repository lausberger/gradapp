# frozen_string_literal: true

Given(/^I am on the approve faculty accounts page$/) do
  visit approve_faculties_path
end

Given(/^There are the following accounts created:$/) do |accounts|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :password_confirmation, :account_type, :research_area]
  accounts.hashes.each do |account|
    account_creation = Account.create!(first_name: account[:first_name], last_name: account[:last_name], email: account[:email],
                                       password: account[:password], password_confirmation: account[:password_confirmation],
                                       account_type: account[:account_type])
    next if account[:research_area].empty?

    Faculty.create!(account_id: account_creation.id, research_area_id: ResearchArea.find_by(title: account[:research_area]).id)
  end
end

When(/^I approve the following faculty account:$/) do |accounts|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :password_confirmation, :account_type, :research_area]
  # pending 'Change to use web ui'
  page.all(:xpath, '//*[@id="main"]/table/tbody/tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    research_area = row.all('td')[2].text
    next unless accounts.hashes.any? { |hash| hash['first_name'] == first_name } && accounts.hashes.any? do |hash|
                  hash['last_name'] == last_name
                end && accounts.hashes.any? do |hash|
                         hash['research_area'] == research_area
                       end

    row.click_link('Approve')
  end
end

Then(/^I should see the following faculty accounts:$/) do |accounts|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :password_confirmation, :account_type, :research_area]
  num_faculty = page.all(:xpath, '//*[@id="main"]/table/tbody/tr').length
  expect(num_faculty).eql? accounts.hashes.length
  page.all(:xpath, '//*[@id="main"]/table/tbody/tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    research_area = row.all('td')[2].text
    expect(accounts.hashes).to include(include('first_name' => first_name))
    expect(accounts.hashes).to include(include('last_name' => last_name))
    expect(accounts.hashes).to include(include('research_area' => research_area))
  end
end

Then(/^I should no longer see the following account:$/) do |accounts|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :password_confirmation, :account_type, :research_area]
  page.all(:xpath, '//*[@id="main"]/table/tbody/tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    expect(accounts.hashes).not_to include(include('first_name' => first_name))
    expect(accounts.hashes).not_to include(include('last_name' => last_name))
  end
end

And(/^I am signed with the email "([^"]*)" and the password "([^"]*)"$/) do |email, password|
  visit login_path
  fill_in('session_email', with: email)
  fill_in('session_password', with: password)
  click_button('Log in')
end

Then(/^I should see an error message saying "([^"]*)"$/) do |error_msg|
  expect(page.all(:css, "div[id='alert']").first.text).to be == error_msg
end

Then(/^I should see a warning message saying "([^"]*)"$/) do |error_msg|
  expect(page.find(:css, "div[id='warning']").text).to eq error_msg
end
