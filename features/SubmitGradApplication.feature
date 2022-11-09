Feature: Allow students to submit graduate applications

  As a Student
  So that I can apply to a university graduate program
  I want to be able to submit my application.

  Background:
    Given I am on the new graduate applications page

  Scenario: Submit a new Application (Declarative)
    Given I fill in my name as "Brandon" "Egger"
    And I fill in my GPA with "3.9"
    When I submit my graduate application
    Then I should see my application status is "submitted"
    And my application's GPA is "3.9"
    And my application's name is "Brandon" "Egger"
