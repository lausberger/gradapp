Feature: log in
    As a user
    So that I can access my profile and associated functionality
    I want to log in to the account I created

Background: I have created an account 
    Given I have created an account

Scenario: log in to account with correct info
    Given I am on the login page
    When I submit the form with good email and good password
    Then I should be redirected to the home page
    And I should see a notice that says "Welcome, " followed by my first name

Scenario: log in to account with incorrect email
    Given I am on the login page
    When I submit the form with good email and bad password
    Then I should not be redirected
    And I should see a warning that says "Email or password is incorrect"

Scenario: log in to account with incorrect password
    Given I am on the login page
    When I submit the form with good email and bad password
    Then I should not be redirected
    And I should see a warning that says "Email or password is incorrect"
