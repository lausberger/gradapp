Feature: Allow students to submit graduate applications

  As a Student
  So that I can apply to a university graduate program
  I want to be able to submit my application.

  Background:
    Given I am signed in as a student
    Given I am creating a new graduate application

  Scenario: Submit a new Application (Declarative)
    Given I fill in my name as "Brandon" "Egger"
    And I fill in my email as "beggr@uiowa.edu" and my phone as "3124438878"
    When I submit my graduate application
    Then I should see a flash saying "Graduate application was successfully submitted."
