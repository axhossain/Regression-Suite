@agent_name @ios
Feature: Check if agent is able assign a case to himself

  Scenario: Open a case and Check if agent is able assign a case to himself
    Given I am signed into the application
    And I go to the detailed view of a case
    When I assign the case to "Me"
    Then the Agent should change
