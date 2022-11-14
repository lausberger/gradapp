Feature: Display an navigate open graduate applications

  As a faculty
  so that I can see potential candidates for my graduate program
  I want to view all student applications

  Background: applications have been added to GradApp

    # TODO: Add dummy applications to table
    Given the following graduate applications have been submitted:

    Given I am on the Graduate Applications home page

  Scenario: I select a students application to view
    When I select to view "Brandon" "Egger"'s graduate application
    Then I should see the application status "complete"
    And the application's GPA is "3.9"
    And the application's name is "Brandon" "Egger"
