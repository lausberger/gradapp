Feature: Delete Discussion

  Scenario: Delete existing discussion without being signed in

    Given I am on the discussions page

    And There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    Then I should not see any "delete" buttons

  Scenario: Delete existing discussion being signed in

    Given There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I am signed with the email "<string>" and the password "<string>"

    And I am on the discussions page

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    When I click on "delete" button for post with title "Test" body "Test" and author "Jack Stockley"

    Then I should not see a discussion post with title "Test 2" and body "Test 3" and author "Jack Stockley"

  Scenario: Delete reply to existing discussion without being signed in

    Given I am on the discussions page

    And There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"

    Then I should not see any "delete" buttons

  Scenario: Delete reply to existing discussion being signed in

    Given There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I am signed with the email "<string>" and the password "<string>"

    And I am on the discussions page

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"

    When I click on "delete" button for post with body "Test" and author "Jack Stockley"

    Then I should not see a discussion post with body "Test 3" and author "Jack Stockley"
