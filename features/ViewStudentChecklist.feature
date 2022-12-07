Feature: View the "Student Checklists" page to see what items needed to completed on a students Application

  Background:
    Given The following account is created:
      | first_name | last_name | email                | password    | password_confirmation | account_type    |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Password123           | Student         |
      | Caleb      | Marx      | caleb-marx@uiowa.edu | password    | password              | Faculty         |

  Scenario: View Student Checklists without being signed in
    Given There is an empty Student Checklist is created for student with email "jnstockley@uiowa.edu"
    When I am on the student checklist page
    Then I should be redirected to the login page

  Scenario: View Student Checklists as faculty member
    And There is an empty Student Checklist is created for student with email "jnstockley@uiowa.edu"
    And I am signed with the email "caleb-marx@uiowa.edu" and the password "password"
    When I am on the student checklist page
    Then I should be redirected to the home page

  Scenario: Student has not completed anything in the student checklist
    Given There is an empty Student Checklist is created for student with email "jnstockley@uiowa.edu"
    And I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"
    When I am on the student checklist page
    Then I should see an empty student checklist

  Scenario: Student has completed some items in their student checklist
    Given The following Student Checklist for student with email "jnstockley@uiowa.edu":
      | type             | completed |
      | citizenship      | true      |
      | research_area    | true      |
      | degree_objective | true      |
    And I am signed with the email "jnstockley@uiowa.edu" and the password "Password123"
    When I am on the student checklist page
    Then I should see the following items have been completed:
      | citizenship      | research_area    | degree_objective |