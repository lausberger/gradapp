Given(/^I am on the Find Faculty page$/) do
  visit faculty_search_path
end

And(/^I have created faculty Members "\{\}"([^"]*)"\{\}"$/) do |faculty_one, faculty_two|
  Faculty.create!(faculty_one)
  Faculty.create!(faculty_two)
end

And(/^I search for "([^"]*)" topic area$/) do |topic_area|
  fill_in('topic_area', :with => topic_area)
  click_button(:id => 'search_topic_area')
end

Then(/^I should see Faculty Members "\{\}"([^"]*)"\{\}"$/) do |faculty_one, faculty_two|
  faculty_one_found = false
  faculty_two_found = false
  all("tr").each do |faculty_row|
    cols = faculty_row.all('td')
    if cols[0].text.eql? faculty_one[:first_name] and cols[1].text.eql? faculty_one[:last_name] and cols[2].text.eql? faculty_one[:topic_area]
      faculty_one_found = true
    elsif cols[0].text.eql? faculty_two[:first_name] and cols[1].text.eql? faculty_two[:last_name] and cols[2].text.eql? faculty_two[:topic_area]
      faculty_two_found = true
    end
    if faculty_one_found and faculty_two_found
      break
    end
  end
  expect(faculty_one_found).to be_truthy
  expect(faculty_two_found).to be_truthy
end

Then(/^I should see Faculty Member "\{\}"$/) do |faculty|
  faculty_found = false
  all("tr").each do |faculty_row|
    cols = faculty_row.all('td')
    if cols[0].text.eql? faculty[:first_name] and cols[1].text.eql? faculty[:last_name] and cols[2].text.eql? faculty[:topic_area]
      faculty_found = true
    end
  end
  expect(faculty_found).to be_truthy
end
