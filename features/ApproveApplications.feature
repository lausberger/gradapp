Feature: Approve or Deny Student Applications

  Scenario: View Application without being signed in

    Given I am on the approve applications page

    And There are the following applications created:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |

    Then I should be redirected to the login page

  Scenario: View Applications without being signed in as a Department Chair user

    Given There are the following applications created:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |

    And I am signed with the email "<string>" and the password "<string>"

    And I am on the approve applications page

    Then I should see an error message saying "<string>"

  Scenario: Approve Application from a Student

    Given There are the following applications created:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |

    And I am signed with the email "<string>" and the password "<string>"

    And I am on the approve applications page

    And I see the following applications:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |

    When I "approve" the following application:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |

    Then I should no longer see the following application:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |


  Scenario: Deny Application from a Student

    Given There are the following applications created:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |

    And I am signed with the email "<string>" and the password "<string>"

    And I am on the approve applications page

    And I see the following applications:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |

    When I "deny" the following application:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |

    Then I should no longer see the following application:
      | first_name | last_name   | email                   | phone      | dob        | status    |
      | Jack       | Stockley    | jnstockley@uiowa.edu    | 7737261974 | 10/13/2000 | submitted |
      | Kaitlynn   | Fuller      | kaitfuller@uiowa.edu    | 8722214561 | 01/01/1999 | submitted |
      | Caleb      | Marx        | cmarx1@uiowa.edu        | 1234567890 | 04/10/2004 | withdrawn |
      | Jonah      | Terwilleger | jdterwilleger@uiowa.edu | 8152544561 | 06/12/1988 | approved  |
