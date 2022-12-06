Feature: Post Discussion

  Scenario: Create new discussion without being signed in

    Given I am on the discussions page

    Then I should not see a button called "Post new Discussion"

  Scenario: Create new discussion being signed in

    Given There are the following accounts created:
      | first_name | last_name | email                | password    | password_confirm | account_type | topic_area |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"

    And I am on the discussions page

    And I see a button called "Post new Discussion"

    When I post a new discussion with title "hello" and body "hello"

    Then I should see a discussion post with title "hello" and body "hello" and author "Jack Stockley"

  Scenario: Reply to discussion without being signed in

    Given I am on the discussions page

    And There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | Stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"

    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"

    Then I should not see a button called "Post Reply"

  Scenario: Reply to discussion being signed in

    Given There are the following accounts created:
      | first_name | last_name | email                | password    | password_confirm | account_type | topic_area |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"

    And I am on the discussions page

    And I have added a discussion with title "Test" and body "Test" and author "Jack Stockley"

    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"

    And I see a button called "Post Reply"

    When I post a reply with body "Hello World"

    Then I should see a discussion post with body "Hello World" and author "Jack Stockley"
