Feature: Add Evaluations to a Student Application

  As a faculty member
  So that I can leave notes about a student to other faculty
  I want to be able to evaluate a student profile I am viewing

  Background:
    Given I am signed in as a faculty
    And viewing a students applications

  Scenario:
    When I score the student with a "4"
    And add the comment "excellent candidate for our program!"
    When I press create evaluation
    Then I should see a flash saying "Evaluation saved!"
