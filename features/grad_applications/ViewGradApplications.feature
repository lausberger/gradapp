Feature: Display an navigate open graduate applications

  As a faculty
  so that I can see potential candidates for my graduate program
  I want to view all student applications

  Background: applications have been added to GradApp

    Given the following graduate applications have been submitted:
      | first_name | last_name | dob          | phone      | email             | status    |
      | John       | Doe       | 25-Nov-1992  | 4968514432 | johndoe@uiowa.edu | denied    |
    Given the following educations for each application:
      | school_name        | start_date | end_date  | currently_attending | degree    | major            | gpa_value | gpa_scale |
      | University of Iowa | 23-8-2019  | 28-5-2023 | true                | bachelor  | Computer Science | 3.5       | 4.0       |

    Given I am on the Graduate Applications home page

  Scenario: I select a students application to view
    When I select to view "John" "Doe"'s graduate application
    Then I should see the application status "denied"
    And the application's average GPA is "3.5"
    And the application's name is "John" "Doe"
    And I should see the education table containing
      | school_name        | start_date | end_date  | currently_attending | degree    | major            | gpa (4.0 scale) |
      | University of Iowa | 8-23-2019  | 5-28-2023 | yes                 | Bachelors | Computer Science | 3.98            |
