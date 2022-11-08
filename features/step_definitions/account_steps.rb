Given /^I am on the account registration page$/ do
    visit register_path
end

def fill_out_form
    fill_in "first_name_field", :with => "Lucas"
    fill_in "last_name_field", :with => "Ausberger"
    fill_in "email_field", :with => "lausberger@uiowa.edu"
    fill_in "password_field", :with => "password"
    fill_in "password_confirm_field", :with => "password"
end

When /^I fill out the form with (.*?)$/ do |option|
    fill_out_form
    case option
    when "\"Student\" selected"
        select "Student", :from => "type_select"
    when "\"Faculty\" selected"
        select "Faculty", :from => "type_select"
    when "non-matching passwords"
        fill_in "password_confirm_field", :with => "different password"
    when "empty fields"
        fill_in "last_name_field", :with => ""
    else
        raise ArgumentError "Unrecognized option: \"#{option}\""
    end
end

And /^I submit the form$/ do
    click_button "Register"
end

Then /^I should be redirected to the home page$/ do
    expect(page).to have_current_path(root_path)
end

And /^I should see a notice that says "(.*?)"$/ do |notice|
    expect(page).to have_content(notice)
end