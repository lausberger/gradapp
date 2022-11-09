Feature: create an account
    As a student/faculty
    So that I can register myself
    I want to create a student/faculty account

Background: I am on the registration page
    Given I am on the account registration page

Scenario: create an account as a Student
    When I fill out the form with "Student" selected
    And I submit the form
    Then I should be redirected to the home page
    And I should see a notice that says "Account registered successfully" 

Scenario: create an account as a Faculty
    When I fill out the form with "Faculty" selected
    And I submit the form
    Then I should be redirected to the home page
    And I should see a notice that says "Account registered successfully"

Scenario: attempt to create an account with non-matching passwords
    When I fill out the form with non-matching passwords
    And I submit the form
    Then I should see a notice that says "Passwords do not match"

Scenario: attempt to create an account with missing fields
    When I fill out the form with empty fields
    And I submit the form
    Then I should see a notice that says "Fields cannot be empty"
