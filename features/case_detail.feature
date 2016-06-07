 @detail
  Feature: Ensure editing of case details in a single case

    Scenario: Edit the assigned agent in a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I edit the Agent of a case
      Then the Agent should change

    Scenario: Edit the assigned group in a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I edit the Group of a case
      Then the Group should change

    Scenario: Edit the Priority of a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I edit the Priority of a case
      Then the Priority should change

    Scenario: Edit the Status of a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I edit the Status of a case
      Then the Status should change

    @ios @labels @wip
    Scenario: Append a label to a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I add a Label to a case
      Then a Label should be added

    @android
    Scenario: Append a label to a case
      Given I am signed into the application
      And I go to the detailed view of a 0 label case
      And I add a Label to a case
      Then a Label should be added

    @ios @labels @wip
    Scenario: Remove a label from a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I add a Label to a case
      Then a Label should be added
      And I remove a Label from a case
      Then a Label should be removed

    @android
    Scenario: Remove a label from a case
      Given I am signed into the application
      And I go to the detailed view of a 1 label case
      And I remove a Label to a case
      Then a Label should be removed

    Scenario: View an agent's name
      Given I am signed into the application
      And I go to the detailed view of a case
      And I view all Agents
      Then I verify Agent name is not public name

    Scenario: Edit the Boolean custom field of a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I edit the Boolean custom field of a case
      Then the Boolean custom field should change

    Scenario: Edit the List custom field of a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I edit the List custom field of a case
      Then the List custom field should change

    Scenario: Edit the Text custom field of a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I edit the Text custom field of a case
      Then the Text custom field should change

    Scenario: Edit the Number custom field of a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I edit the Number custom field of a case
      Then the Number custom field should change

    Scenario: Edit the Date custom field of a case
      Given I am signed into the application
      And I go to the detailed view of a case
      And I edit the Date custom field of a case
      Then the Date custom field should change
