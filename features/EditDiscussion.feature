Feature: Edit Discussion

  Background:
    Given There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirmation | account_type | research_area |
      | Jack       | Stockley  |jnstockley@uiowa.edu | Password123 | Password123           | Student      |            |

  Scenario: Edit existing discussion without being signed in
    Given I am on the discussions page
    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    Then I should not see any "edit" buttons

  Scenario: Edit existing discussion being signed in
    Given I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"
    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    And I am on the discussions page
    When I click on "Edit" button for post with title "Test" body "Test" and author "Jack Stockley"
    And I change the title to "Test 2" and body to "Test 3"
    Then I should see a discussion post with title "Test 2" and body "Test 3" and author "Jack Stockley"

  Scenario: Edit reply to existing discussion without being signed in

    Given I am on the discussions page
    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"
    Then I should not see any "Edit" buttons

  Scenario: Edit reply to existing discussion being signed in
    Given I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"
    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    And There is reply to discussion post with title "Test" and body "Test" with body "Hello" by "Jack Stockley"
    And I am on the discussions page
    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"
    When I click on "Edit" button for post with body "Hello" and author "Jack Stockley"
    And I change the body to "Test 3"
    Then I should see a discussion post with body "Test 3" and author "Jack Stockley"
