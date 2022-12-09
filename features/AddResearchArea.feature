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
  Then I should see "New Research Area"

Scenario: Try to access the creation form while signed in as a department chair
  Given I have created a department chair account
  And I am signed in to my account
  When I have visited the GradApp Home Page
  And I have clicked "Add Research Areas"
  Then I should see "New Research Area"

Scenario: Submit the form with valid input
  Given I have created a faculty account
  And I am signed in to my account
  When I have visited the GradApp Home Page
  And I have clicked "Add Research Areas"
  When I fill out the research area form with "Central Computers", "Studying Central Computers", and "By Studying Computer we can find centrals"
  Then I should be redirected to the research areas page
  And I should see a notice that says "Research area successfully added"
