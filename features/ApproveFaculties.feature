Feature: Approve New Faculty Member Accounts

  Scenario: View faculties needing approval without being signed in
    Given I am on the approve faculty accounts page
    And There are the following accounts created:
      | first_name | last_name   | email                   | password    | password_confirmation | account_type     | topic_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123 | Password123           | Faculty          | Networks    |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | password    | password              | Faculty          | Criminology |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | Hawkeyes    | Hawkeyes              | Student          |             |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | iL0V3iowA   | iL0V3iowA             | Department Chair |             |
    Then I should be redirected to the login page

  Scenario: View faculties needing approval without being signed in as a Departmental Chair user
    Given There are the following accounts created:
      | first_name | last_name   | email                   | password    | password_confirmation | account_type     | topic_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123 | Password123           | Faculty          | Networks    |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | password    | password              | Faculty          | Criminology |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | Hawkeyes    | Hawkeyes              | Student          |             |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | iL0V3iowA   | iL0V3iowA             | Department Chair |             |
    And I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"
    And I am on the approve faculty accounts page
    Then I should see an error message saying "You must be a department chair to approve new accounts"

  Scenario: View faculties needing approval signed in as a Departmental Chair user
    Given There are the following accounts created:
      | first_name | last_name   | email                   | password    | password_confirmation | account_type     | topic_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123 | Password123           | Faculty          | Networks    |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | password    | password              | Faculty          | Criminology |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | Hawkeyes    | Hawkeyes              | Student          |             |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | iL0V3iowA   | iL0V3iowA             | Department Chair |             |
    And I am signed with the email "jdterwilleger@uiowa.edu" and the password "iL0V3iowA"
    And I am on the approve faculty accounts page
    Then I should see the following faculty accounts:
      | first_name | last_name   | email                   | password    | password_confirmation | account_type     | topic_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123 | Password123           | Faculty          | Networks    |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | password    | password              | Faculty          | Criminology |

  Scenario: Approve Faculty Member needing approval
    Given There are the following accounts created:
      | first_name | last_name   | email                   | password    | password_confirmation | account_type     | topic_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123 | Password123           | Faculty          | Networks    |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | password    | password              | Faculty          | Criminology |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | Hawkeyes    | Hawkeyes              | Student          |             |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | iL0V3iowA   | iL0V3iowA             | Department Chair |             |
    And I am signed with the email "jdterwilleger@uiowa.edu" and the password "iL0V3iowA"
    And I am on the approve faculty accounts page
    And I should see the following faculty accounts:
      | first_name | last_name   | email                   | password    | password_confirmation | account_type     | topic_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123 | Password123           | Faculty          | Networks    |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | password    | password              | Faculty          | Criminology |
    When I approve the following faculty account:
      | first_name | last_name   | email                   | password    | password_confirmation | account_type     | topic_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123 | Password123           | Faculty          | Networks    |
    Then I should no long see the following account:
      | first_name | last_name   | email                   | password    | password_confirmation | account_type     | topic_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123 | Password123           | Faculty          | Networks    |


