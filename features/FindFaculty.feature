Feature: View the 'Faculty' page to view specified faculty

  Scenario: View all the Faculty

    Given I am on the Find Faculty page

    And I have created faculty Members "{}" and "{}"

    When I am on the Find Faculty page

    Then I should see Faculty Members "{}" and "{}"

  Scenario: View all the Faculty in a certain topic area

    Given I am on the Find Faculty page

    And I have created faculty Members "{}" and "{}"

    When I am on the Find Faculty page

    And I search for "CSE" topic area

    Then I should see Faculty Member "{}"
