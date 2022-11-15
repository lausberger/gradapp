Feature: Display an navigate open graduate applications

  As a faculty
  so that I can see potential candidates for my graduate program
  I want to view all student applications

  Background: applications have been added to GradApp

    Given the following graduate applications have been submitted:
      | first_name | last_name | dob          | phone      | email             | gpa_value | gpa_scale | status    |
      | John       | Doe       | 25-Nov-1992  | 4968514432 | johndoe@uiowa.edu | 3.9       | 5.0       | denied    |

    Given I am on the Graduate Applications home page

  Scenario: I select a students application to view
    When I select to view "John" "Doe"'s graduate application
    Then I should see the application status "denied"
    And the application's GPA is "3.12"
    And the application's name is "John" "Doe"
