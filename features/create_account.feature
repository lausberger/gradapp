Feature: create an account

Scenario: create an account as a Student
    When I visit the account registration page
    And I fill out the form with "Student" selected
    And I submit the form
    Then I should be redirected to the home page
    And I should see a notice that says "Account registered successfully" 

Scenario: create an account as a Faculty
    When I visit the account registration page
    And I fill out the form with "Faculty" selected
    And I submit the form
    Then I should be redirected to the home page
    And I should see a notice that says "Account registered successfully"

Scenario: attempt to create an account with non-matching passwords
    When I visit the account registration page
    And I fill out the form with non-matching passwords
    And I submit the form
    Then I should see a notice that says "Passwords do not match"

Scenario: attempt to create an account with missing fields
    When I visit the account registration page
    And I fill out the form with empty fields
    And I submit the form
    Then I should see a notice that says "Please fill out all fields"
