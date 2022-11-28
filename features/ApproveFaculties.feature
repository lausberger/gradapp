Feature: Approve New Faculty Member Accounts

  Scenario: View all Faculty Accounts needing to be approve

    Given I am on the approve faculty accounts page

    And There are the following accounts created:
      | first_name | last_name | email                | password    | account_type | topic_area  |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Faculty      | Networks    |
      | Kaitlynn   | Fuller    | kaitfuller@uiowa.edu | password    | Faculty      | Criminology |
      | Caleb      | Marx      | cmarx1@uiowa.edu     | Hawkeyes    | Student      |             |

    Then I should see the following faculty accounts:
      | first_name | last_name | email                | password    | account_type | topic_area  |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Faculty      | Networks    |
      | Kaitlynn   | Fuller    | kaitfuller@uiowa.edu | password    | Faculty      | Criminology |

  Scenario: Approve Faculty Member Account

    Given I am on the approve faculty accounts page

    And There are the following accounts created:
      | first_name | last_name | email                | password    | account_type | topic_area  |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Faculty      | Networks    |
      | Kaitlynn   | Fuller    | kaitfuller@uiowa.edu | password    | Faculty      | Criminology |
      | Caleb      | Marx      | cmarx1@uiowa.edu     | Hawkeyes    | Student      |             |


    When I approve the following faculty account:
      | first_name | last_name | email                | password    | account_type | topic_area  |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Faculty      | Networks    |

    And I am on the approve faculty accounts page

    Then I should no long see the following account:
      | first_name | last_name | email                | password    | account_type | topic_area  |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Faculty      | Networks    |
