Feature: Allow the user to view the correct home page

Scenario: View the home page while not signed in
  Given I have logged out
  When I have visited the GradApp Home Page
  Then I should see "Public Homepage"

Scenario: View the Home Page
  When I have visited the GradApp Home Page
  Then I should see "Graduate Programs"

Scenario: View the Home Page Manually
  When I go to the url "/home"
  Then I should see "Graduate Programs"

Scenario: Navigate to another page from the Home Page
  When I have visited the GradApp Home Page
  And I have clicked "FAQ"
  Then I should not see "Graduate Programs"
