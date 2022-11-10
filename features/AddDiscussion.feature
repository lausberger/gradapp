Feature: Allow user to create a new Discussion post

  Scenario: Add a new root discussion post

    When I have added a discussion with the title "Any recommendations on program" and body "I am having issues determining which program I want to go into does anyone have any suggestions?" and author "Jack Stockley"

    When I am on the discussions home page

    Then I should see the discussion post by "Jack Stockley"


  Scenario: Post a reply to a current discussion post

    Given I have added a discussion with the title "Any recommendations on program" and body "I am having issues determining which program I want to go into does anyone have any suggestions?" and author "Jack Stockley"

    Given I am on the discussion page with the title "Any recommendations on program" and authored by "Jack Stockley"

    When I post a reply with body "I heard the CSE Graduate program is really good" and authored by "Hans Johnson"

    Then I should see a reply with body "I heard the CSE Graduate program is really good" and authored by "Hans Johnson"
