Feature: Allow a user to visit a FAQ page

Scenario: View the FAQ page from Home Page
  When I have visited the GradApp Home Page
  And I have clicked "FAQ"
  Then I should see "Frequently Asked Questions"

Scenario: View the FAQ page manually
  When I go to the url "/faq"
  Then I should see "Frequently Asked Questions"
