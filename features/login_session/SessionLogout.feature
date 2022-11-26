Feature: log out
  As a user
  So that I can end my login session
  I want to be able to log out

Background: I am signed in
  Given I have created an account
  Given I am signed in to my account

Scenario: log out of my account
  Given I have logged out
  Then I should be redirected to the home page
  And I should see a notice that says "You have been signed out successfully"

Scenario: attempt to view profile when logged out
  Given I have logged out
  When I attempt to visit the profile page
  Then I should be redirected to the login page
  And I should see a notice that says "You must be logged in to view your profile"