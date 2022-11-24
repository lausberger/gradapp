Feature: Education history for graduate applications

  As a student
  so that I can show professors my academic background and experience
  I want to add past educational institutes I've attended to my application

  Background:
    Given I am creating a new graduate application
    Given I have already filled out my application personal details
    Given I have already filled out my application contact details

  Scenario: Add an education to the application
    Given I create a new education input field
    And I fill in my school name as "University of Iowa"
    And I set my start date as "8-23-2019" and my end date as "5-28-2023"
    And I set currently attending to "true"
    And I set my study as a "Bachelors" in "Computer Science"
    And I fill in my GPA as "3.98" out of "4.00"
    When I submit my graduate application
    Then I should see the education table containing
      | school_name        | start_date | end_date  | currently_attending | degree    | major            | gpa_ratio |
      | University of Iowa | 8-23-2019  | 5-28-2023 | yes                 | Bachelors | Computer Science | 3.98      |
