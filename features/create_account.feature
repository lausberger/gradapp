Feature: create an account
    As a student/faculty
    So that I can register myself
    I want to create a student/faculty account

Background: I am on the registration page
    Given I am on the account registration page

Scenario: create an account as a Student
    When I fill out the form with email "student@email.com" and "Student" selected
    And I submit the form
    Then I should be redirected to the home page
    And I should see a notice that says "Account registration successful" 

Scenario: create an account as a Faculty
    When I fill out the form with email "faculty@email.com" and "Faculty" selected
    And I submit the form
    Then I should be redirected to the home page
    And I should see a notice that says "Account registration successful"

Scenario: attempt to create an account with non-matching passwords
    When I fill out the form with email "password-noob@email.com" and non-matching passwords
    And I submit the form
    Then I should see a notice that says "Passwords do not match"

Scenario: attempt to create an account with missing fields
    When I fill out the form with email "form-incompleter@email.com" and empty fields
    And I submit the form
    Then I should see a notice that says "Fields cannot be empty"
