Feature: View Discussion

  Scenario: View all the discussions

    Given I am on the discussions page

    And There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"

    Then I should see a discussion post with title "Test" and body "Test" and author "Jack Stockley"

  Scenario: View all discussion replies

    Given I am on the discussions page

    And There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    And There is reply to discussion post with title "Test" and body "Test" with body "Hello World" by "Jack Stockley"

    Then I should see a reply with "Hello World" by "Jack Stockley" to post "Test" with body "Test" by "Jack Stockley"
