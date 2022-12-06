Feature: View Discussions

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

Feature: Post Discussion

  Scenario: Create new discussion without being signed in

    Given I am on the discussions page

    Then I should not see a button called "Post new Discussion"

  Scenario: Create new discussion being signed in

    Given There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I am signed with the email "<string>" and the password "<string>"

    And I am on the discussions page

    And I see a button called "Post new Discussion"

    When I post a new discussion with title "hello" and body "hello"

    Then I should see a discussion post with title "<string>" and body "<string>" and author "<string>"

  Scenario: Reply to discussion without being signed in

    Given I am on the discussions page

    And There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"

    Then I should not see a button called "Post Reply"

  Scenario: Reply to discussion being signed in

    Given There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I am signed with the email "<string>" and the password "<string>"

    And I am on the discussions page

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"

    And I see a button called "Post new Discussion"

    When I post a reply with body "Hello World"

    Then I should see a reply with body "Hello World" by "Jack Stockley"

Feature: Edit Discussion

  Scenario: Edit existing discussion without being signed in

    Given I am on the discussions page

    And There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    Then I should not see any "edit" buttons

  Scenario: Edit existing discussion being signed in

    Given There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I am signed with the email "<string>" and the password "<string>"

    And I am on the discussions page

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    When I click on "edit" button for post with title "Test" body "Test" and author "Jack Stockley"

    And I change the title to "Test 2" and body to "Test 3"

    Then I should see a discussion post with title "Test 2" and body "Test 3" and author "Jack Stockley"

  Scenario: Edit reply to existing discussion without being signed in

    Given I am on the discussions page

    And There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"

    Then I should not see any "edit" buttons

  Scenario: Edit reply to existing discussion being signed in

    Given There are the following accounts created:
      | first_name | last_name | email               | password    | password_confirm | account_type | topic_area |
      | Jack       | stockley  |jnstockley@uiowa.edu | Password123 | Password123      | Student      |            |

    And I am signed with the email "<string>" and the password "<string>"

    And I am on the discussions page

    And There is discussion post with the title "Test" and body "Test" and author "Jack Stockley"

    And I am on the reply page for post title "Test" and body "Test" and author "Jack Stockley"

    When I click on "edit" button for post with body "Test" and author "Jack Stockley"

    And I change the body to "Test 3"

    Then I should see a discussion post with body "Test 3" and author "Jack Stockley"

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
