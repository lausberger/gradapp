Feature: View the 'Faculty' page to view specified faculty

  Background:
    Given The following research areas have been created:
      | title    | summary                       | detailed_overview                                                                      |
      | Networks3 | A test networks research area | This research area is made to tests faculty, and it represent a possible networks area |

    Given The following accounts have been created:
      | first_name | last_name | email                   | password    | password_confirmation | account_type | research_area |
      | Jack       | Stockley  | jack-stockley@uiowa.edu | Password123 | Password123           | Faculty      | Networks3      |
      | Hans       | Johnson   | hans-johnson@uiowa.edu  | iloveselt   | iloveselt             | Faculty      | Networks3       |
      | Caleb      | Marx      | caleb-marx@uiowa.edu    | pA55W0rd!   | pA55W0rd!             | Student      |            |

  Scenario: View all the Faculty
    Given I am on the Find Faculty page
    Then I should see Faculty Members:
      | first_name | last_name | research_area |
      | Jack       | Stockley  | Networks3      |
      | Hans       | Johnson   | Networks3   |

  Scenario: View all the Faculty in a certain topic area
    Given I am on the Find Faculty page
    And I search for "Networks3" research area
    Then I should see Faculty Members:
      | first_name | last_name |
      | Jack       | Stockley  |
    | Hans          | Johnson |
