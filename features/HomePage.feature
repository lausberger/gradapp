Feature: Allow the user to view the correct home page

Scenario: View the home page while not signed in
  Given I have visited the GradApp Home Page
  Then I should see "Public Homepage"

Scenario: View the home page while signed in as a student
  Given I have created a student account
  And I am signed in to my account
  When I have visited the GradApp Home Page
  Then I should see "Student Home Page"

Scenario: View the home page while signed in as a faculty
  Given I have created a faculty account
  And I am signed in to my account
  When I have visited the GradApp Home Page
  Then I should see "Faculty Homepage"

Scenario: View the home page while signed in as department chair
  Given I have created a department chair account
  And I am signed in to my account
  When I have visited the GradApp Home Page
  Then I should see "Department Chair Homepage"

Scenario: View the Home Page
  When I have visited the GradApp Home Page
  Then I should see "Graduate Programs"

Scenario: View the Home Page Manually
  When I go to the url "/home"
  Then I should see "Graduate Programs"

Scenario: Navigate to another page from the Home Page
  When I have visited the GradApp Home Page
  And I have clicked "FAQ"
  Then I should not see "Graduate Programs"
