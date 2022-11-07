Feature: Allow a User to view the GradApp Home Page

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
