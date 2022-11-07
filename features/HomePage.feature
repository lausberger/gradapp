Feature: Allow a User to view the GradApp Home Page

Scenario: View the Home Page
  When I have visited the GradApp Home Page
  Then I should see "Graduate Applications Home Page"

Scenario: Navigate to another page from the Home Page
  When I have visited the GradApp Home Page
  And I have clicked "FAQ"
  Then I should not see "Graduate Applications Home Page"
