Feature: Allow a User to view their messages

  Background: messages have been added to the database
    Given the following accounts have been added:
      | first_name     | last_name   | email           | password | password_confirmation | account_type     |
      | John           | Doe         | jdoe@gmail.com  | 12345678 | 12345678              | Student          |
      | Jane           | Doe         | jadoe@gmail.com | 12345678 | 12345678              | Faculty          |
    Given the following messages have been sent to John Doe:
      | to_id     | from_id  | to_email         | from_email      | subject       | body       |
      | 1         | 2        | jdoe@gmail.com   | jadoe@gmail.com | Hello.        | Hi. Hey.   |
    Given the following messages have been sent:
      | to_id     | from_id  | to_email         | from_email      | subject       | body       |
      | 2         | 1        | jdoe@gmail.com   | jdoe@gmail.com  | Talk.         | Important. |

  Scenario: View the Messages Page when not Logged in
    When I have visited the messages page
    Then I should see "You must be logged in to perform that action"
    And I should not see "My Messages"

  Scenario: View the Messages Page Manually when not Logged in
    When I go to the url "/messages"
    Then I should see "You must be logged in to perform that action"
    And I should not see "My Messages"

  Scenario: View the Messages Page when Logged in
    When I have logged in as John Doe
    And I have visited the messages page
    Then I should see "jadoe@gmail.com"
    And I should see "Hello"
    And I should see "Hi. Hey."
    And I should not see "Talk."
    And I should not see "Important."

  Scenario: View the Messages Page Manually when Logged in
    When I have logged in as John Doe
    And I go to the url "/messages"
    Then I should see "jadoe@gmail.com"
    And I should see "Hello"
    And I should see "Hi. Hey."
    And I should not see "Talk."
    And I should not see "Important."

  Scenario: Navigate to another page from the Messages Page
    When I have logged in as John Doe
    When I have visited the messages page
    And I have clicked "New Message"
    Then I should see "Go Back"