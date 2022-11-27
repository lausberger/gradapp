#TODO: Once login is implemented there may need to be changes to some tests
Feature: Allow a User to Send a Message
  Background: There is an account in the database
    Given the following accounts have been added:
      | first_name     | last_name   | email         | password_digest | type     |
      | John           | Doe         | jdoe@gmail.com| 1234            | Student  |

  Scenario: Send a message to the wrong email
    When I have visited the send messages page
    And I fill in the 'to' with 'doe@gmail.com'
    And I fill in the 'subject' with 'Hello'
    And I fill in the 'body' with 'Test'
    And I have clicked the button 'Send Message'
    Then I should see 'Please enter a correct email address'
    And I should see 'New Message'

  Scenario: Send a message with no body
    When I have visited the send messages page
    And I fill in the 'to' with 'jdoe@gmail.com'
    And I fill in the 'subject' with 'Hello'
    And I have clicked the button 'Send Message'
    Then I should see 'Please enter a body for your message'
    And I should see 'New Message'

  Scenario: Correctly send a message
    When I have visited the send messages page
    And I fill in the 'to' with 'jdoe@gmail.com'
    And I fill in the 'subject' with 'Hello'
    And I fill in the 'body' with 'Test'
    And I have clicked the button 'Send Message'
    Then I should see 'Message Sent'
    And I should see 'My Messages'
    And I should not see 'New Message'

  Scenario: I no longer want to send a message
    When I have visited the send messages page
    And I have clicked 'Return to My Messages'
    Then I should see 'My Messages'
    And I should not see 'New Message'


