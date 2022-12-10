Feature: Viewing Student Evaluations

  As a faculty member
  So that I can see the notes left by other faculty
  I want to be able to view all of a student's evaluations

  Background:
    Given I am signed in as a faculty
    When the following application evaluations have been added

  Scenario:
    Then I should see an evaluation with score "5" and comment "nice work!"
