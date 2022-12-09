Feature: View Research Area

  Background:
    Given The following research areas have been created:
      | title    | summary                       | detailed_overview                                                                      |
      | Networks Test 1 | A test networks research area | This research area is made to tests faculty, and it represent a possible networks area |
    Given There are the following accounts created:
      | first_name | last_name   | email                   | password     | password_confirmation | account_type     | research_area  |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | Password123  | Password123           | Faculty          | Networks Test 1    |

  Scenario: Accessing the view all research areas page from the home page while not signed in
    Given I have visited the GradApp Home Page
    And I have clicked "Find Research Areas"
    Then I should see "Networks Test 1"

  Scenario: Accessing the view all research areas page from the home page while signed in as a student
    Given I have created a student account
    And I am signed in to my account
    And I have visited the GradApp Home Page
    And I have clicked "Find Research Areas"
    Then I should see "Networks Test 1"

  Scenario: Viewing specific research area from the index research areas page
    Given I have visited the GradApp Home Page
    And I have clicked "Find Research Areas"
    And I have clicked "View More"
    Then I should see "Networks Test 1"
    And I should see "jnstockley@uiowa.edu"


