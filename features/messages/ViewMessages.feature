Feature: Allow a User to view their messages

  Background: messages have been added to the database
    Given the following accounts have been added:
      | first_name     | last_name   | email           | password_digest | type             |
      | John           | Doe         | jdoe@gmail.com  | 1234            | Student          |
      | Jane           | Doe         | jadoe@gmail.com | 1234            | Faculty          |
    Given the following messages have been sent:
      | to_id     | from_id  | to_email         | from_email      | subject       | body       |
      | 1         | 2        | jdoe@gmail.com   | jadoe@gmail.com | Hello.        | Hi. Hey.   |
      | 2         | 1        | jadoe@gmail.com  | jdoe@gmail.com  | Talk.         | Important. |


  #TODO: Need to remove pending and update for when logged in is added.
  Scenario: View the Messages Page when not Logged in
    When pending
    When I have visited the messages page
    Then I should see "My Messages"
    And I should not see "Hello"

  Scenario: View the Messages Page Manually when not Logged in
    When pending
    When I go to the url "/messages"
    Then I should see "My Messages"
    And I should not see "Hello"

    #TODO: Add in the logic for logging in
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
    When pending
    When I have visited the messages page
    And I have clicked "Send Message"
    Then I should see "Return to My Messages"
