Feature: Allow the user to delete a Discussion post

  Scenario: Delete the root discussion post

    Given I have added a discussion with the title "Any recommendations on program" and body "I am having issues determining which program I want to go into does anyone have any suggestions?" and author "Jack Stockley"

    When I have deleted the discussion with the title "Any recommendations on program" authored by "Jack Stockley"

    And I am on the discussion page with the title "Any recommendations on program" and authored by "Jack Stockley"

    Then I should not see the discussion post by "Jack Stockley"

    Then I should be redirected to the discussion homepage

  Scenario: Delete a reply to a discussion post

    Given I have added a discussion with the title "Any recommendations on program" and body "I am having issues determining which program I want to go into does anyone have any suggestions?" and author "Jack Stockley"

    Given I am on the discussion page with the title "Any recommendations on program" and authored by "Jack Stockley"

    Given There is a reply with body "I heard the CSE Graduate program is really good" authored by "Hans Johnson"

    When I have deleted the discussion with the title "I heard the CSE Graduate program is really good" authored by "Hans Johnson"

    Then I should not see the discussion post by "Hans Johnson"

    Then I should be redirected to the discussion page for the discussion with title "Any recommendations on program" authored by "Jack Stockley"
