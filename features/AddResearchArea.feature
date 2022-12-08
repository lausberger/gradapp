Feature: Create A New Research Area

Scenario: Try to find the creation form while not signed in
  Given I have visited the GradApp Home Page
  Then I should not see "Add Research Areas"

Scenario: Try to find the creation form while signed in as a student
  Given I have created a student account
  And I am signed in to my account
  When I have visited the GradApp Home Page
  Then I should not see "Add Research Areas"

Scenario: Try to access the creation form while signed in as a faculty
  Given I have created a faculty account
  And I am signed in to my account
  When I have visited the GradApp Home Page
  And I have clicked "Add Research Areas"
  Then I should see "Add Research Area Form"

Scenario: Try to access the creation form while signed in as a department chair
  Given I have created a department chair account
  And I am signed in to my account
  When I have visited the GradApp Home Page
  And I have clicked "Add Research Areas"
  Then I should see "Add Research Area Form"
