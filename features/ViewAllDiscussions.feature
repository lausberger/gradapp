Feature: View the "Discussions" page to see all Discussions

  Scenario: View all the discussions on the main "discussions" page
    Given I have added a discussion with the title "How do I sign up" and body "I am having issues signing up, how would I do that and" and author "Jack Stockley"
    When I am on the discussions home page
    Then I should see the discussion post by "Jack Stockley"
    