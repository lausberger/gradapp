Feature: Allow the user to edit a Discussion post

  Scenario: Edit the root discussion post

    Given I have added a discussion with the title "Any recommendations on program" and body "I am having issues determining which program I want to go into does anyone have any suggestions?" and author "Jack Stockley"

    When I am on the discussion page with the title "Any recommendations on program" and authored by "Jack Stockley"

    When I edit the discussion titled "Any recommendations on program" by "Jack Stockley" with title "What factually members focus on cyber security" and body "Hello I have applied to the CSE grad program and am looking for faculty who focus in cyber security any recommendations"

    Then I should see the discussion post by "Jack Stockley" with title "What factually members focus on cyber security" and body "Hello I have applied to the CSE grad program and am looking for faculty who focus in cyber security any recommendations"

  Scenario: Edit a reply to a discussion post

    Given I have added a discussion with the title "Any recommendations on program" and body "I am having issues determining which program I want to go into does anyone have any suggestions?" and author "Jack Stockley"

    Given I am on the discussion page with the title "Any recommendations on program" and authored by "Jack Stockley"

    Given There is a reply with body "I heard the CSE Graduate program is really good" authored by "Hans Johnson"

    When I edit discussion reply with body "I heard the CSE Graduate program is really good" authored by "Hans Johnson" to body "I would reach out to your advisor for help deciding which program"

    Then I should see a reply with body "I would reach out to your advisor for help deciding which program" and authored by "Hans Johnson"
