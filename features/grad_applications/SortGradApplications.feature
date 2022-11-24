Feature: Sort graduate applications based on measurable criteria

  As a faculty
  so that I can quickly find excellent students for my program
  I want to sort student applications based on GPA and test scores

  Background:
    Given I am creating a new graduate application

  Scenario: I want to sort students based on GPA
    When I sort graduate applications based on "gpa"
    Then I should see "John Doe"'s application before "Brandon Egger"'s
