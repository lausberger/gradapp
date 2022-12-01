# frozen_string_literal: true

Given(/^I am on the approve applications page$/) do
  visit approve_applications_path
end

And(/^There are the following applications created:$/) do |applications|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :phone, :dob, :status]
  applications.hashes.each do |application|
    GraduateApplication.create!(first_name: application[:first_name], last_name: application[:last_name], email: application[:email],
                                phone: application[:phone], dob: application[:dob], status: application[:status])
  end
end

And(/^I see the following applications:$/) do |applications|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :phone, :dob, :status]
  num_accounts = page.all(:xpath, '//*[@id="main"]/table/tbody/tr').length
  expect(num_accounts).eql? applications.hashes.length
  page.all(:xpath, '//*[@id="main"]/table/tbody/tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    email = row.all('td')[2].text
    phone = row.all('td')[3].text
    dob = row.all('td')[4].text
    expect(applications.hashes).to include(include('first_name' => first_name))
    expect(applications.hashes).to include(include('last_name' => last_name))
    expect(applications.hashes).to include(include('email' => email))
    expect(applications.hashes).to include(include('phone' => phone))
    expect(applications.hashes).to include(include('dob' => dob))
  end
end

When(/^I "([^"]*)" the following application:$/) do |decision, applications|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :phone, :dob, :status]
  page.all(:xpath, '//*[@id="main"]/table/tbody/tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    email = row.all('td')[2].text
    phone = row.all('td')[3].text
    dob = row.all('td')[4].text
    next unless applications.hashes.any? { |hash| hash['first_name'] == first_name } && applications.hashes.any? do |hash|
      hash['last_name'] == last_name
    end && applications.hashes.any? do |hash|
      hash['email'] == email
    end && applications.hashes.any? do |hash|
      hash['phone'] == phone
    end && applications.hashes.any? do |hash|
      hash['dob'] == dob
    end

    row.click_button(decision)
  end
end

Then(/^I should no longer see the following application:$/) do |applications|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :phone, :dob, :status]
  page.all(:xpath, '//*[@id="main"]/table/tbody/tr').each do |row|
    first_name = row.all('td')[0].text
    last_name = row.all('td')[1].text
    email = row.all('td')[2].text
    phone = row.all('td')[3].text
    dob = row.all('td')[4].text
    expect(applications.hashes).not_to include(include('first_name' => first_name))
    expect(applications.hashes).not_to include(include('last_name' => last_name))
    expect(applications.hashes).not_to include(include('email' => email))
    expect(applications.hashes).not_to include(include('phone' => phone))
    expect(applications.hashes).not_to include(include('dob' => dob))
  end
end
