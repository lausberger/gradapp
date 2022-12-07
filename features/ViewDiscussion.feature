Feature: View Discussion

  Background:
    Given There are the following accounts created:
      | first_name | last_name | email                | password    | password_confirm | account_type | topic_area |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

  Scenario: View all the discussions
    Given I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    When I am on the discussions page
    Then I should see a discussion post with title "Test" and body "Test" and author "Jack Stockley"

  Scenario: View all discussion replies
    Given I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"
    And There is reply to discussion post with title "Test" and body "Test" with body "Hello World" by "Jack Stockley"
    When I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"
    Then I should see a discussion post with body "Hello World" and author "Jack Stockley"