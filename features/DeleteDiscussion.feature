Feature: Delete Discussion

  Background:
    Given There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | Stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

  Scenario: Delete existing discussion without being signed in
    Given I am on the discussions page
    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    Then I should not see any "Delete" buttons

  Scenario: Delete existing discussion being signed in
    Given I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"
    And I am on the discussions page
    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    When I click on "Delete" button for post with title "Test" body "Test" and author "Jack Stockley"
    Then I should not see a discussion post with title "Test 2" and body "Test 3" and author "Jack Stockley"

  Scenario: Delete reply to existing discussion without being signed in
    Given I am on the discussions page
    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"
    Then I should not see any "Delete" buttons

  Scenario: Delete reply to existing discussion being signed in
    Given I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"
    And I am on the discussions page
    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    And There is reply to discussion post with title "Test" and body "Test" with body "Hello" by "Jack Stockley"
    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"
    When I click on "Delete" button for post with body "Hello" and author "Jack Stockley"
    Then I should not see a discussion post with body "Hello" and author "Jack Stockley"