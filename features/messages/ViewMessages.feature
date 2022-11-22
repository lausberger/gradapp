Feature: Allow a User to view their messages

  Background: messages have been added to the database
    Given the following messages have been sent:
    | to          | from        | subject       | body          |
    | John Doe    | Jane Doe    | Hello         | Hi. Hey.      |
    | Jane Doe    | John Doe    | What's Up     | How are you?  |
    | John Doe    | Jimmy Zee   | Work Time     | You're late.  |

  Scenario: View the Messages Page when not Logged in
    When I have visited the messages page
    Then I should see "My Messages"
    And I should not see "Hello"

  Scenario: View the Messages Page Manually when not Logged in
    When I go to the url "/messages"
    Then I should see "My Messages"
    And I should not see "Hello"

  Scenario: View the Messages Page when Logged in
    When I have logged in as "John Doe"
    And I have visited the messages page
    Then I should see "Jane Doe"
    And I should see "Hello"
    And I should see "Hi. Hey."

  Scenario: View the Messages Page Manually when Logged in
    When I have logged in as "John Doe"
    And I go to the url "/messages"
    Then I should see "Jane Doe"
    And I should see "Hello"
    And I should see "Hi. Hey."

  Scenario: Navigate to another page from the Messages Page
    When I have visited the messages page
    And I have clicked the button "Send Message"
    Then I should not see "My Messages"
