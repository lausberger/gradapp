Feature: Allow a User to Send a Message
  Background: There is an account in the database
    Given the following accounts have been added:
      | first_name     | last_name   | email          | password | password_confirmation | account_type |
      | John           | Doe         | jdoe@gmail.com | 12345678 | 12345678              | Student      |

  Scenario: I am not logged in
    When I have visited the send messages page
    Then I should see 'You must be logged in to perform that action'
    And I should not see 'New Message'

  Scenario: Send a message to the wrong email
    When I have logged in as John Doe
    And I have visited the send messages page
    And I fill in the 'to' with 'doe@gmail.com'
    And I fill in the 'subject' with 'Hello'
    And I fill in the 'body' with 'Test'
    And I have clicked the button 'Send'
    Then I should see 'Please enter a correct email address'
    And I should see 'New Message'

  Scenario: Send a message with no body
    When I have logged in as John Doe
    And I have visited the send messages page
    And I fill in the 'to' with 'jdoe@gmail.com'
    And I fill in the 'subject' with 'Hello'
    And I have clicked the button 'Send'
    Then I should see 'Please enter a body for your message'
    And I should see 'New Message'

  Scenario: Correctly send a message
    When I have logged in as John Doe
    And I have visited the send messages page
    And I fill in the 'to' with 'jdoe@gmail.com'
    And I fill in the 'subject' with 'Hello'
    And I fill in the 'body' with 'Test'
    And I have clicked the button 'Send'
    Then I should see 'Message Sent'
    And I should see 'My Messages'
    # will confuse with Sender: otherwise
    And I should not see 'Send\n'

  Scenario: I no longer want to send a message
    When I have logged in as John Doe
    And I have visited the send messages page
    And I have clicked 'Go Back'
    Then I should see 'My Messages'
    # will confuse with Sender: otherwise
    And I should not see 'Send\n'