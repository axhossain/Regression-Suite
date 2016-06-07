@search
Feature: Ensure searching

  Scenario: Search for a non-existing case
    Given I am signed into the application
    And I search for "I do not exist"
    Then I should get 0 results

  Scenario: Search for an existing case
    Given I am signed into the application
    And I search for "test"
    Then I should get at least 1 result
