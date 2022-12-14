Feature: Approve or Deny Student Applications

  Background:
    Given The following research areas have been created:
      | title    | summary                       | detailed_overview                                                                      |
      | Networks1 | A test networks research area | This research area is made to tests faculty, and it represent a possible networks area |
    Given There are the following applications created:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 2000-10-13 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 1999-01-01 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 2004-04-10 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 1998-06-12 | accepted  |
    Given There are the following accounts created:
      | first_name | last_name   | email                   | password     | password_confirmation | account_type     | research_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123  | Password123           | Faculty          | Networks1    |

  Scenario: View Application without being signed in
    Given I am on the approve applications page
    Then I should be redirected to the login page

  Scenario: View Applications without being signed in as a Department Chair user
    Given I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"
    And I am on the approve applications page
    Then I should see an error message saying "You must be a department chair to make decisions on graduate applications"

  Scenario: Approve Application from a Student
    Given I am signed with the email "jdterwilleger@uiowa.edu" and the password "iL0V3iowA"
    And I am on the approve applications page
    And I see the following applications:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 2000-10-13 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 1999-01-01 | submitted |
    When I "Approve" the following application:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 2000-10-13 | submitted |
    Then I should no longer see the following application:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 2000-10-13 | submitted |

  Scenario: Deny Application from a Student
    And I am signed with the email "jdterwilleger@uiowa.edu" and the password "iL0V3iowA"
    And I am on the approve applications page
    And I see the following applications:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 2000-10-13 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 1999-01-01 | submitted |
    When I "Deny" the following application:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 2000-10-13 | submitted |
    Then I should no longer see the following application:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 2000-10-13 | submitted |
