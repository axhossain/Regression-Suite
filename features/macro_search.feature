@macro
Feature: Ensure macro searching

  @ios
  Scenario: Search for a non-existing case
    Given I am signed into the application
    And I go to the conversation view of a case
    And I view the list of macros
    And I search the list of macros for "I do not exist"
    Then I should get 0 results

  @ios
  Scenario: Search for an existing case
    Given I am signed into the application
    And I go to the conversation view of a case
    And I view the list of macros
    And I search the list of macros for "Thanks for feedback + Resolve"
    Then I should get at least 1 result
