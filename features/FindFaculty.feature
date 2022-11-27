Feature: View the 'Faculty' page to view specified faculty

  Scenario: View all the Faculty

    Given I am on the Find Faculty page

    And I the following accounts have been created:
      | first_name | last_name | email                  | password    | account_type | topic_area |
      | Jack       | Stockley  | jack-stockley@uiowa.edu   | Password123 | Faculty      | CSE        |
      | Hans       | Johnson   | hans-johnson@uiowa.edu | i<3SelT     | Faculty      | math       |
      | Caleb      | Marx      | caleb-marx@uiowa.edu   | pA55W0rd!   | Student      |            |


    When I am on the Find Faculty page

    Then I should see Faculty Members:
      | first_name | last_name | topic_area |
      | Jack       | Stockley  | CSE        |
      | Hans       | Johnson   | Math       |


  Scenario: View all the Faculty in a certain topic area

    Given I am on the Find Faculty page

    And I the following accounts have been created:
      | first_name | last_name | email                  | password    | account_type | topic_area |
      | Jack       | Stockley  | jack-stockley@uiowa.edu   | Password123 | Faculty      | CSE        |
      | Hans       | Johnson   | hans-johnson@uiowa.edu | i<3SelT     | Faculty      | math       |
      | Caleb      | Marx      | caleb-marx@uiowa.edu   | pA55W0rd!   | Student      |            |

    When I am on the Find Faculty page

    And I search for "CSE" topic area

    Then I should see Faculty Members:
      | first_name | last_name |
      | Jack       | Stockley  |
