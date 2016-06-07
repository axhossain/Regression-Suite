@bulk @ios
Feature: Ensure Bulk Editing Functionality

  Scenario: Verify I can bulk edit agents
    Given I am signed into the application
    And I select the cases on screen for bulk editing
    And I reassign the cases
    Then the cases should be reassigned

    #this can fail intermittently because of MI-951
  Scenario: Verify I can bulk edit status
    Given I am signed into the application
    And I select the cases on screen for bulk editing
    And I change the status of the cases
    Then the statuses should be changed

  @labels @wip
  Scenario: Verify I can bulk edit label
    Given I am signed into the application
    And I select the cases on screen for bulk editing
    And I change the label of the cases
    Then the label should be changed
