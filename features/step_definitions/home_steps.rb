When /^ I have visited the GradApp Home Page$/ do
  visit gradapp_path
end

When /^ I have clicked the link "(.*?)"$/ do |string|
  click_on string
end

Then /^ I should see "(.*?)"$/ do |string|
  expect(page).to have_content(string)
end
