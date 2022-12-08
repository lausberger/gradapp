Feature: View Research Area

  Background:
    Given The following research areas have been created:
      | title    | summary                       | detailed_overview                                                                      |
      | Networks Test 1 | A test networks research area | This research area is made to tests faculty, and it represent a possible networks area |

  Scenario: Accessing the view all research areas page from the home page while not signed in
    Given I have visited the GradApp Home Page
    And I have clicked "Find Research Areas"
    Then I should see "Networks Test 1"

  Scenario: Accessing the view all research areas page from the home page while signed in as a student
    Given I have created a student account
    And I am signed in to my account
    Then I have visited the GradApp Home Page
    And I have clicked "Find Research Areas"
    Then I should see "Networks Test 1"
