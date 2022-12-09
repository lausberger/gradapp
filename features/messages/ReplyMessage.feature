Feature: Allow a user to reply to messages

  Background: messages have been added to the database
    Given the following accounts have been added:
      | first_name     | last_name   | email           | password | password_confirmation | account_type     |
      | John           | Doe         | jdoe@gmail.com  | 12345678 | 12345678              | Student          |
      | Jane           | Doe         | jadoe@gmail.com | 12345678 | 12345678              | Faculty          |
    Given the following messages have been sent to John Doe:
      | to_id     | from_id  | to_email         | from_email      | subject       | body       | messages_id |
      | 1         | 2        | jdoe@gmail.com   | jadoe@gmail.com | Hello.        | Hi. Hey.   |             |
      | 1         | 1        | jdoe@gmail.com   | jdoe@gmail.com  | From Me.      | To Me.     |             |
      | 1         | 2        | jdoe@gmail.com   | jadoe@gmail.com | A Reply.      | To You.    | 4           |
    Given the following messages have been sent:
      | to_id     | from_id  | to_email         | from_email      | subject       | body       | messages_id |
      | 2         | 1        | jdoe@gmail.com   | jdoe@gmail.com  | Talk.         | Important. |             |

  Scenario: View the reply page when not logged in
    When I have visited the replies page
    Then I should see "You must be logged in to perform that action"
    And I should not see "My Messages"

  Scenario: View the reply page manually when not logged in
    When I go to the url "/messages/reply.1"
    Then I should see "You must be logged in to perform that action"
    And I should not see "My Messages"

  Scenario: View the reply page for a specific message
    When I have logged in as John Doe
    And I view the reply page for message "1"
    Then I should see "Hello."
    And I should see "Hi. Hey."
    And I should see "Body"

  Scenario: Send a reply to a message
    When I have logged in as John Doe
    And I view the reply page for message "1"
    And I fill in the "body_box" with "This is a test message"
    And I have clicked the button "Reply"
    Then I should not see "This is a test message"

  Scenario: View a reply sent to you
    When I have logged in as John Doe
    And I have visited the messages page
    Then I should see "A Reply."
    And I should see "To You."
    And I should see "Message Context"
    And I should see "Talk."
    And I should see "Important."

  Scenario: Try to view a reply page for a message you were not sent
    When I have logged in as John Doe
    And I view the reply page for message "4"
    Then I should see "You cannot view this message"
