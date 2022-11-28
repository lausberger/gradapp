Feature: View the "Student Checklists" page to see what items needed to completed on a students Application

  Scenario: Student has not completed anything in the student checklist

    Given The following account is created:
      | first_name | last_name | email                | password    | account_type    |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Student |

    And There is an empty Student Checklist is created for student with email "jnstockley@uiowa.edu"

    And I am on the student checklist page for student with email "jnstockley@uiowa.edu"

    Then I should see an empty student checklist

  Scenario: Student has completed some items in their student checklist

    Given The following account is created:
      | first_name | last_name | email                | password    | account_type    |
      | Jack       | Stockley  | jnstockley@uiowa.edu | Password123 | Student |

    And The following Student Checklist for student with email "jnstockley@uiowa.edu":
      | type             | completed |
      | citizenship      | true      |
      | research_area    | true      |
      | degree_objective | true      |

    And I am on the student checklist page for student with email "jnstockley@uiowa.edu"

    Then I should see the following items have been completed:
      | citizenship      | research_area    | degree_objective |

